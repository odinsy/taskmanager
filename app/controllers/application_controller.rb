class ApplicationController < ActionController::Base

  before_filter :require_login

  protect_from_forgery with: :exception
  before_action :set_layout_variables

  def set_layout_variables
    @proj = Project.active
  end

  private

  def not_authenticated
    flash[:warning] = 'You have to authenticate to access this page.'
    redirect_to login_path
  end

end
