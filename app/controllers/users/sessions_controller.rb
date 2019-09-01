class Users::SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_name(signin_params[:name])
    if user && user.authenticate(signin_params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome to MyShop!"
      redirect_to root_url
    else
      flash[:alert] = "Invalid name or password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully signed out!"
    redirect_to root_url
  end

  private

    def signin_params
      params.require(:signin).permit(:name, :password)
    end
end
