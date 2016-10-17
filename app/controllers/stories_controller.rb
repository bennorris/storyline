require 'pry'
class StoriesController < ApplicationController
  before_action :authenticate_user!

  def create
    @story = Story.new(story_params)
    @story.user = current_user
    @story.users << current_user
    if @story.save
      redirect_to user_path(current_user)
    else
      redirect_to user_path
    end
  end

  def edit
    @story = Story.find_by_id(params[:id])
  end

  def update
    add_to_story
    redirect_to story_path(@story)
  end

  def show
    @story = Story.find_by_id(params[:id])
  end


private

  def story_params
    params.require(:story).permit(:content)
  end

  def add_to_story
    @story = Story.find_by_id(params[:id])
    @story.content = @story.content + " " + story_params[:content]
    @story.users << current_user if !@story.users.include?(current_user)
    @story.save
  end

end
