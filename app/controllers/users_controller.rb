class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_or_create_by(user_resource_params)
    if(@user.save)
      session[:user_id] = @user.id
      redirect_to(ideas_path)
    else
      render 'new'
    end
  end

  private


#Needed by the hierarchy of the form resource
  def user_resource_params
    params.require(:user).permit(:email)
  end

end
