class Users::RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(signup_params)

    if @user.save
      flash[:notice] = t("user.registration.confirm_email")
      redirect_to root_path
    else
      render :new
    end
  end

  private

    def signup_params
      params.require(:signup).permit(:name, :email, :password, :password_confirmation)
    end
end
