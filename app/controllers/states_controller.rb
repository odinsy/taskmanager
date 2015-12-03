class StatesController < ApplicationController

  def completed
    @tasks = current_user.tasks.completed
    @projects = current_user.projects.completed
  end

end
