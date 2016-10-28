class StoriesController < ApplicationController
  before_action :authenticate_user!

  def create
    @story = current_user.stories.build(story_params)
    @story.full_story = @story.beginning

    if @story.save

      redirect_to user_path(current_user), :flash => { :success => "Success! You can find your story below, in the 'Your Stories' section." }
    else
      redirect_to user_path(current_user), :flash => { :error => "Story cannot be blank and must be under 100 characters." }
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
    @sentence = Sentence.new

  end

  def destroy
    story = Story.find_by_id(params[:id])

    if story.user_id == current_user.id
      #need to also destroy the sentences associated with the story
      story.destroy
      redirect_to user_path(current_user)
    else
      redirect_to user_path(current_user), :flash => { :error => "You can only delete your own stories!" }
    end
  end



private

  def story_params
    params.require(:story).permit(:beginning)
  end

  def add_to_story
    @story = Story.find_by_id(params[:id])
    @story.full_story = @story.full_story + " " + story_params[:beginning]
    @story.users << current_user
    @story.save
  end

end
