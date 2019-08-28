class IdeasController < ApplicationController
  def index
    @search_term = params[:search_input]
    logger.info("The search term is #{@search_term}.")
    @ideas = Idea.search(@search_term)
    logger.info("The ideas existing are #{@ideas}.")
  end

  def new
    @idea = Idea.new
  end

  def show
    @idea = Idea.find(params[:id])
    @comment = Comment.new
  end

  def create
    @idea = Idea.new(idea_resource_params)
    if(@idea.save)
      redirect_to(account_ideas_path)
    else
      render 'new'
    end
  end

  def edit
    id = params[:id]
    @idea=Idea.find(id)
  end

  def update
    # extract the identifier from the params Hash
    id = params[:id]

    # retrieve the instance using the identifier
    @idea = Idea.find(id)
    if(@idea.update(idea_resource_params))
      redirect_to(account_ideas_path)
    else
      render 'edit'
    end

  end

  private


#Needed by the hierarchy of the form resource
  def idea_resource_params
    params.require(:idea).permit(
      :title, :photo_url, :done_count, :description)
  end


end
