class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :set_layout_variables

  def set_layout_variables
    @projects = Project.all
  end

end
