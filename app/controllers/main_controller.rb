class MainController < ApplicationController

  skip_before_filter :require_login
  layout 'main'

  def index
    redirect_to tasks_path if current_user
  end

end
