class SessionsController < ApplicationController

  skip_before_filter :require_login, only: [:new, :create]
  layout 'main'

  def new
  end

  def create
    if login(params[:session][:email], params[:session][:password])
      redirect_to tasks_path, notice: "Login successful"
    else
      render "new", notice: "Login failed!"
    end
  end

  def destroy
    logout
    redirect_back_or_to root_path
  end

end
