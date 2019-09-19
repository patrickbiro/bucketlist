class UsersController < ApplicationController
  before_action :ensure_admin, only: [:edit, :update]

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if(user.update(user_edit_admin_params))
      redirect_to(account_path)
    else
      render 'edit'
    end
  end

  def ensure_admin
    if(current_user.role == 'admin')
      return
    end
    redirect_to(account_path)
  end


  private


  #Needed by the hierarchy of the form resource
  def user_resource_params
    params.require(:user).permit(:email, :password)
  end

  def user_edit_admin_params
    params.require(:user).permit(
      :name, :email, :role, :avatar_url)
  end

end
