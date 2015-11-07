class SubtasksController < ApplicationController

  before_action :find_subtask, only: [:edit, :update, :destroy, :run, :complete]

  def run
    @subtask.run!
    redirect_to :back
  end

  def complete
    @subtask.complete!
    redirect_to :back
  end

  def create
    @task = current_user.tasks.find(params[:task_id])
    @subtask = @task.subtasks.create(subtask_params)
    redirect_to @subtask.task
  end

  def edit
  end

  def update
  end

  def destroy
    @subtask.destroy
    redirect_to @subtask.task
  end

  private

    def subtask_params
      params.require(:subtask).permit(:title, :user_id, :task_id).deep_merge!(user_id: current_user.id)
    end

    def find_subtask
      @subtask = current_user.subtasks.find(params[:id])
    end

end
