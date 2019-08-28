class CommentsController < ApplicationController
  def create
    @idea = Idea.find(params[:idea_id])
    @comment = Comment.new(comment_resource_params)
    @comment.idea = @idea
    @comment.save!
    redirect_to(idea_path(@idea))

  end



  private


#Needed by the hierarchy of the form resource
  def comment_resource_params
    params.require(:comment).permit(
      :body, :reference)
  end


end
