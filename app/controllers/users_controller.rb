class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_resource_params)
    if(@user.save)
      session[:user_id] = @user.id
      redirect_to(account_ideas_path)
    else
      render 'new'
    end
  end

  private


#Needed by the hierarchy of the form resource
  def user_resource_params
    params.require(:user).permit(:email, :password)
  end

end
