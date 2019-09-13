class CommentsController < ApplicationController
  def create
    @idea = Idea.find(params[:idea_id])
    @user = User.find(session[:user_id])
    @comment = Comment.new(comment_resource_params)
    @comment.idea = @idea
    @comment.user = @user
    @comment.save!
    redirect_to(review_path(@idea))

  end



  private


#Needed by the hierarchy of the form resource
  def comment_resource_params
    params.require(:comment).permit(
      :body, :reference)
  end


end
