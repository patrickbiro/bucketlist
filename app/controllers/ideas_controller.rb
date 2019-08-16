class IdeasController < ApplicationController
  def index
    @search_term = params[:search_input]
    logger.info("The search term is #{@search_term}.")
  end
end
