class AccountController < ApplicationController
  before_action :ensure_authenticated

  helper_method :current_user

  def ideas
    user_id = session[:user_id]
    user = User.find(user_id)
    @ideas = user.ideas

    logger.info("The ideas existing are #{@ideas}.")
  end

  def edit
    #will use current_user helper method instead
  end

  def update
    if(current_user.update(user_params))
      redirect_to(account_path)
    else
      render 'edit'
    end
  end

  def goals
    @goals = current_user.goals
  end



  def ensure_authenticated
    unless(logged_in?)
      redirect_to new_session_path
    end
  end

  def user_params
    params.require(:user).permit(
      :name, :email, :avatar_url)
  end

  def current_user
    User.find(session[:user_id])
  end

end
