class TasksController < ApplicationController

  before_action :find_task, only: [:show, :edit, :update, :destroy, :run, :complete]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_task
  respond_to :html, :js

  def run
    @task.run!
    @project = @task.project
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'tasks' }
    end
  end

  def complete
    @task.complete!
    @project = @task.project
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'tasks' }
    end
  end

  def tomorrow
    @tasks = current_user.tasks.active.tomorrow
  end

  def scheduled
    @tasks = current_user.tasks.active.scheduled
  end

  def waiting
    @tasks = current_user.tasks.active.waiting
  end

  def index
    @tasks = current_user.tasks.active.today
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
    end
    respond_to do |format|
      if project_present
        @project = @task.project
        format.js
      elsif @task.errors.empty?
        format.html { redirect_to tasks_path, notice: "Task created!" }
      else
        format.html { render 'new', notice: "Could not save task" }
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
    @project = @task.project
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js { render 'tasks' }
    end
  end

  private

    def task_params
      params.require(:task).permit(:title, :description, :scheduled, :deadline, :user_id, :project_id, :priority)
    end

    def find_task
      @task = current_user.tasks.find(params[:id])
    end

    def invalid_task
      redirect_to tasks_path, notice: "Invalid task!"
    end

    def project
      return unless project_present
      Project.find(params[:project_id])
    end

    def project_present
      params[:project_id].present?
    end

end
