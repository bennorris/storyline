class StoriesController < ApplicationController

  def create
    @story = Story.new(story_params)
    @story.user = current_user
    if @story.save
      redirect_to user_path(current_user)
    else
      redirect_to user_path
    end
  end




private

  def story_params
    params.require(:story).permit(:content)
  end

end
