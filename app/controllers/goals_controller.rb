class GoalsController < ApplicationController
  before_action :ensure_authenticated

  def create
    @user = current_user
    @idea = Idea.find(params[:idea_id])
    logger.warn('User and idea exist!')
    @user.goals << @idea
    respond_to do |format|
      format.html { redirect_to(idea_path(@idea)) }
      format.js
    end
  end
end
