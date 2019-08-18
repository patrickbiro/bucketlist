class IdeasController < ApplicationController
  def index
    @search_term = params[:search_input]
    logger.info("The search term is #{@search_term}.")
    @ideas = Idea.all
    logger.info("The ideas existing are #{@ideas}.")
  end
  def new
  end
  def create
    idea = Idea.new
    idea.title = params[:title]
    idea.done_count = params[:done_count]
    idea.photo_url = params[:photo_url]
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

    idea.title = params[:title]
    idea.done_count = params[:done_count]
    idea.photo_url = params[:photo_url]
    idea.save!
    redirect_to(account_ideas_path)
  end


end
