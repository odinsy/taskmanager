class ProfileController < ApplicationController

  def show
  end

  def edit
  end

  def update
    if current_user.update_attributes(user_params)
      redirect_to root_path, notice: "Your profile has been updated!"
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:profile).permit(:email, :password, :password_confirmation)
  end
  
end
