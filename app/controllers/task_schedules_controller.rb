class TaskSchedulesController < ApplicationController

  def tomorrow
    @tasks = current_user.tasks.main.active.tomorrow
  end

  def scheduled
    @tasks = current_user.tasks.main.active.scheduled
  end

  def waiting
    @tasks = current_user.tasks.main.active.waiting
  end

end
