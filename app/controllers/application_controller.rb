class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :set_layout_variables

  def set_layout_variables
    @proj = Project.active
  end

end
