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
    @tasks = Task.main.in_work.today
  end

  def tomorrow
    @tasks = Task.main.in_work.tomorrow
  end

  def scheduled
    @tasks = Task.main.in_work.scheduled
  end

  def waiting
    @tasks = Task.main.in_work.waiting
  end

  def completed
    @tasks = Task.main.completed
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
      params.require(:task).permit(:title, :description, :scheduled, :deadline, :priority, :project, subtasks_attributes: [:title, :priority])
    end

    def find_task
      @task = Task.find(params[:id])
    end

    def invalid_task
      redirect_to tasks_path, notice: "Invalid card!"
    end

end
