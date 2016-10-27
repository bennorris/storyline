class StoriesController < ApplicationController
  before_action :authenticate_user!

  def create
    @story = current_user.stories.build(story_params)

    if @story.save
      sentence = @story.sentences.build(user_id: current_user.id, story_id: @story.id, content: @story.content)
      sentence.save
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




private

  def story_params
    params.require(:story).permit(:content)
  end

  def add_to_story
    @story = Story.find_by_id(params[:id])
    @story.content = @story.content + " " + story_params[:content]
    @story.users << current_user
    @story.save
  end

end
