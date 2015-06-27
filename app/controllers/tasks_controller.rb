class TasksController < ApplicationController

  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.main.today
  end

  def tomorrow
    @tasks = Task.main.tomorrow
  end

  def scheduled
    @tasks = Task.main.scheduled
  end

  def waiting
    @tasks = Task.main.waiting
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.create(task_params)
    if @task.errors.empty?
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def update
    @task.update_attributes(task_params)
    if @task.errors.empty? || :subtasks_attributes?
      redirect_to @task
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    if @task.parent_id?
      redirect_to @task.parent
    else
      redirect_to tasks_path
    end
  end

  private

    def task_params
      params.require(:task).permit(:title, :description, :scheduled, :deadline, :priority, :project, subtasks_attributes: [:title])
    end
    def find_task
      @task = Task.find(params[:id])
    end

end
