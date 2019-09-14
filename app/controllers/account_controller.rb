class AccountController < ApplicationController
  before_action :ensure_authenticated

  def ideas
    user_id = session[:user_id]
    user = User.find(user_id)
    @ideas = user.ideas

    logger.info("The ideas existing are #{@ideas}.")
  end

  def ensure_authenticated
    unless(logged_in?)
      redirect_to new_session_path
    end
  end

end
