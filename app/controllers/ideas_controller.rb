class IdeasController < ApplicationController
  def index
    @search_term = params[:search_input]
    logger.info("The search term is #{@search_term}.")
    @ideas = Idea.search(@search_term)
    logger.info("The ideas existing are #{@ideas}.")
  end

  def new
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def create
    idea = Idea.new(idea_params)
    idea.save!
    redirect_to(account_ideas_path)
  end

  def edit
    id = params[:id]
    @idea=Idea.find(id)
  end

  def update
    # extract the identifier from the params Hash
    id = params[:id]

    # retrieve the instance using the identifier
    idea = Idea.find(id)
    idea.update(idea_params)
    redirect_to(account_ideas_path)
  end

  private

  def idea_params
    params.permit(:title, :done_count, :photo_url, :name_of_user, :description)
  end

end
