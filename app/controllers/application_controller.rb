class ApplicationController < ActionController::Base

  before_filter :require_login

  protect_from_forgery with: :exception

  private

  def not_authenticated
    flash[:warning] = 'You have to authenticate to access this page.'
    redirect_to login_path
  end

end
