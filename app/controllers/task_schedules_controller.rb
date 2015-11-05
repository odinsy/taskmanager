class TaskSchedulesController < ApplicationController

  def tomorrow
    @tasks = current_user.tasks.active.tomorrow
  end

  def scheduled
    @tasks = current_user.tasks.active.scheduled
  end

  def waiting
    @tasks = current_user.tasks.active.waiting
  end

end
