# encoding: utf-8
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

  def edit
    @user = User.new
  end

  def update
    # account_update_params = params[:user]

    # @user = User.find_by_username_and_student_id(params[:user][:username],
    #   params[:user][:student_id])
    @user = User.where( 
      username: params[:user][:username],
      student_id: params[:user][:student_id],
      realname: params[:user][:realname]
      ).first
    # ,
    #   
    logger.debug "====#{@user}="
    account_update_params = params[:user]
    account_update_params.delete("username")
    account_update_params.delete("realname")
    account_update_params.delete("student_id")
    
    
    if !@user.nil? and @user.update_attributes(account_update_params)
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      @user = User.new
      flash[:notice] = "정보가 일치하지 않습니다."
      render 'edit'
    end
  end
end

