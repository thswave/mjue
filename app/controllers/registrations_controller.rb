class RegistrationsController < ApplicationController
  skip_before_filter :authenticate_user!

  def new
    @user = User.new
  end

  # POST /resource
  def create
    @user = User.new params[:user]

    if @user.save
      sign_in(:user, @user)

      redirect_to root_path
    else
      render :new
    end
  end
end

