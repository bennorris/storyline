class StoriesController < ApplicationController
  before_action :authenticate_user!

  def create
    @story = current_user.stories.build(story_params)

    if @story.save
      sentence = @story.sentences.build(user_id: current_user.id, story_id: @story.id, content: @story.content)
      sentence.also_story = true
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

  def destroy
    story = Story.find_by_id(params[:id])
    also_sentence = Sentence.find_by(content: story.content)
    if also_sentence.also_story == true && also_sentence.user_id == current_user.id
      also_sentence.destroy
    end
    if story.user_id == current_user.id
      story.destroy
      redirect_to user_path(current_user)
    else
      redirect_to user_path(current_user), :flash => { :error => "You can only delete your own stories!" }
    end
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
