class TasksController < ApplicationController

  before_action :find_task, only: [:show, :edit, :update, :destroy, :run, :complete]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_task

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

  def tomorrow
    @tasks = current_user.tasks.main.active.tomorrow
  end

  def scheduled
    @tasks = current_user.tasks.main.active.scheduled
  end

  def waiting
    @tasks = current_user.tasks.main.active.waiting
  end

  def completed
    @tasks = current_user.tasks.main.completed
  end

  def show
  end

  def new
    @task = current_user.tasks.build
  end

  def edit
  end

  def create
    if params[:project_id]
      @project = current_user.projects.find(params[:project_id])
      @task = @project.tasks.create(task_params)
      if @task.errors.empty?
        redirect_to @project, notice: "Task created!"
      else
        redirect_to @project, notice: "Invalid input!"
      end
    else
      @task = current_user.tasks.create(task_params)
      if @task.errors.empty?
        redirect_to tasks_path, notice: "Task created!"
      else
        render 'new', notice: "Invalid input!"
      end
    end
  end

  def update
    @task.update_attributes(task_params)
    if task_params[:subtasks_attributes] or @task.errors.empty?
      redirect_to task_path
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    if @task.parent_id?
      redirect_to @task.parent
    else
      redirect_to :back
    end
  end

  private

    def task_params
      params.require(:task).permit(:title, :description, :scheduled, :deadline, :priority, :user_id, :project_id, subtasks_attributes: [:title, :user_id]).deep_merge!(user_id: current_user.id)
    end

    def find_task
      @task = current_user.tasks.find(params[:id])
    end

    def invalid_task
      redirect_to tasks_path, notice: "Invalid task!"
    end

end
