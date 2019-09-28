class AccountController < ApplicationController
  before_action :ensure_authenticated

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

  def user_params
    params.require(:user).permit(
      :name, :email, :avatar)
  end

end
