class IdeasController < ApplicationController
  include RolesHelper

  before_action :ensure_authenticated, only: [:edit, :update, :new, :create]
  before_action :load_idea,         only: [:edit, :update]
  before_action :authorize_to_edit_idea,         only: [:edit, :update]


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


    @display_add_comment = session[:user_id].present?
    @idea = Idea.find(params[:id])
    @comment = Comment.new

    if (session[:user_id].present?)
      @user=User.find(session[:user_id])
      @disable_add_goal = @user.goals.exists?(@idea.id)
    else
      @user=nil
    end
  end

  def create
    user=User.find(session[:user_id])
    @idea = Idea.new(idea_resource_params)
    @idea.user = user
    if(@idea.save)
      redirect_to(account_goals_path)
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if(@idea.update(idea_resource_params))
      redirect_to(account_goals_path)
    else
      render 'edit'
    end

  end

  def load_idea
    @idea = Idea.find(params[:id])
  end


  def authorize_to_edit_idea
    redirect_to(account_path) unless(can_edit?(@idea))
  end

  private


  #Needed by the hierarchy of the form resource
  def idea_resource_params
    params.require(:idea).permit(
      :title, :photo_url, :done_count, :description)
    end


  end
