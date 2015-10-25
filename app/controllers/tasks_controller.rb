class TasksController < ApplicationController

  before_action :find_task, only: [:show, :edit, :update, :destroy, :run, :complete]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_task
  respond_to :html, :js

  def run
    @task.run!
    redirect_to :back
  end

  def complete
    @task.complete!
    redirect_to :back
  end

  def index
    @tasks = current_user.tasks.main.active.today
  end

  def show
  end

  def new
    @task = current_user.tasks.build
  end

  def edit
    session[:return_to] ||= request.referer
  end

  def create
    @task = current_user.tasks.create(task_params) do |t|
      t.project = project if project_present
      t.parent = parent if parent_present
    end
    if @task.errors.empty?
      flash.now[:notice] = "Task created!"
      if project_present
        redirect_to @task.project
      elsif parent_present
        redirect_to @task.parent
      else
        redirect_to tasks_path
      end
    else
      flash.now[:notice] = "Invalid input!"
      if project_present
        redirect_to @task.project
      elsif parent_present
        redirect_to @task.parent
      else
        render 'new'
      end
    end
  end

  def update
    @task.update_attributes(task_params)
    if @task.errors.empty?
      redirect_to session.delete(:return_to)
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to :back
  end

  private

    def task_params
      params.require(:task).permit(:title, :description, :scheduled, :deadline, :priority, :user_id, :project_id, :parent_id)
    end

    def find_task
      @task = current_user.tasks.find(params[:id])
    end

    def invalid_task
      redirect_to tasks_path, notice: "Invalid task!"
    end

    def parent
     return unless parent_present
     Task.find(params[:task_id])
    end

    def project
      return unless project_present
      Project.find(params[:project_id])
    end

    def parent_present
      params[:task_id].present?
    end

    def project_present
      params[:project_id].present?
    end

end
