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

end
