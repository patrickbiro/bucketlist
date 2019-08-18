class AccountController < ApplicationController
  def ideas
    @ideas = Idea.all
    logger.info("The ideas existing are #{@ideas}.")
  end
end
