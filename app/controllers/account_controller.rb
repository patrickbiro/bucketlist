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
    @user = current_user
  end

  def update

  end


  def ensure_authenticated
    unless(logged_in?)
      redirect_to new_session_path
    end
  end



  def current_user
    User.find(session[:user_id])
  end

end
