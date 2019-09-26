class GoalsController < ApplicationController
  before_action :ensure_authenticated

  def create
    @user = current_user
    @idea = Idea.find(params[:idea_id])
    logger.info('User and idea exist!')
    @user.goals << @idea
    respond_to do |format|
      format.html { redirect_to(idea_path(@idea)) }
      format.js
    end
  end

  def destroy
    user = current_user
    logger.info("USER ID #{user.id}")
    idea = Idea.find(params[:id])
    logger.info("IDEA ID #{idea.id}")
    user.goals.destroy idea
    redirect_to(account_goals_path)


  end
end
