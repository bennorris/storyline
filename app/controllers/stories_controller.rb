require 'pry'
class StoriesController < ApplicationController
  before_action :authenticate_user!

  def create
    @story = current_user.stories.build(story_params)

    if @story.save
      story_user = @story.story_users.build(user_id: current_user.id, story_id: @story.id)
      story_user.save
      @story.users << current_user
      redirect_to user_path(current_user)
    else
      render user_path
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
    binding.pry 
    @story = Story.find_by_id(params[:id])
    @story.content = @story.content + " " + story_params[:content]
    @story.users << current_user
    @story.save
  end

end
