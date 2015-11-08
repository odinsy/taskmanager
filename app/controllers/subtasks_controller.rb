class SubtasksController < ApplicationController

  before_action :find_subtask, only: [:edit, :update, :destroy, :run, :complete]

  respond_to :html, :js

  def run
    @task = @subtask.task
    @subtask.run!
  end

  def complete
    @task = @subtask.task
    @subtask.complete!
  end

  def create
    @task = current_user.tasks.find(params[:task_id])
    @subtask = @task.subtasks.create(subtask_params)
  end

  def edit
  end

  def update
  end

  def destroy
    @task = @subtask.task
    @subtask.destroy
  end

  private

    def subtask_params
      params.require(:subtask).permit(:title, :user_id, :task_id).deep_merge!(user_id: current_user.id)
    end

    def find_subtask
      @subtask = current_user.subtasks.find(params[:id])
    end

end
