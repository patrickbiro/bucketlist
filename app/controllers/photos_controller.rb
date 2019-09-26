class PhotosController < ApplicationController
  include RolesHelper

  before_action :ensure_authenticated
  before_action :load_idea
  before_action :authorize_to_edit_idea

  def create
    #@idea.photo_url = params[:photo_url]
    #@idea.save
    @idea.update_attributes photo_url: params[:photo_url]
    redirect_to(edit_idea_path(@idea))
  end

  def index
    query = params[:query]
    query = @idea.title if (query.blank?)
    begin
      @photo = Unsplash::Photo.random(query: query, count: 5)
    rescue => exception
      @error = "#{exception.message}"
    end

  end

  private

  def load_idea
    @idea = Idea.find(params[:idea_id])
  end

  def authorize_to_edit_idea
    redirect_to(account_path) unless(can_edit?(@idea))
  end

end
