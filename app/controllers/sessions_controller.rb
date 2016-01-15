class SessionsController < ApplicationController

  skip_before_filter :require_login, only: [:new, :create]
  layout 'main'

  def new
  end

  def create
    if login(params[:session][:email], params[:session][:password])
      flash[:success] = "Login successful"
      redirect_back_or_to tasks_path
    else
      flash[:alert] = "Email or password was invalid!"
      render "new"
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

end
