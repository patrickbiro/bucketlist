class CommentsController < ApplicationController
  before_action :ensure_authenticated

  def create
    @idea = Idea.find(params[:idea_id])
    @comment = Comment.new(comment_resource_params)
    @comment.idea = @idea
    @comment.user = current_user
    @comment.save!
  end



  private


#Needed by the hierarchy of the form resource
  def comment_resource_params
    params.require(:comment).permit(
      :body, :reference)
  end


end
