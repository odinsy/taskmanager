class RegistrationsController < ApplicationController

  skip_before_filter :require_login, only: [:new, :create]
  layout 'main'

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.errors.empty?
      auto_login(@user)
      flash[:success] = "The user was successfully created!"
      redirect_to tasks_path
    else
      flash[:alert] = "Registration failed!"
      render "new"
    end
  end

  private

  def user_params
    params.require(:registration).permit(:email, :password, :password_confirmation)
  end

end
