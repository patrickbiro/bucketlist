class StylesController < ApplicationController
  def atoms

  end

  def molecules
    @idea = Idea.all.first
  end

  def organisms
    @ideas = Idea.most_recent()
  end
end
