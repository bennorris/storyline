class StoriesController < ApplicationController
  before_action :authenticate_user!

  def create

    #save this - will use when nested form is removed from home page.
    @story = Story.new(story_params)
    @story = current_user.stories.build(story_params)
    @story.full_story = @story.beginning

    if @story.save
      redirect_to user_path(current_user), :flash => { :success => "Success! You can find your story below, in the 'Your Stories' section." }
    else
      redirect_to user_path(current_user), :flash => { :error => "Story cannot be blank and must be under 100 characters." }
    end
  end


  def show
    @story = Story.find_by_id(params[:id])
    @sentence = Sentence.new
  end

  def destroy
    story = Story.find_by_id(params[:id])

    if story.user_id == current_user.id
      story.destroy
      redirect_to user_path(current_user), :flash => { :success => "Your story has been deleted!" }
    else
      redirect_to user_path(current_user), :flash => { :error => "You can only delete your own stories!" }
    end
  end

  def index
      @stories = Story.all.select { |story| story.user_id == current_user.id}
      respond_to do |f|
        f.html {render :index}
        f.json {render json: @stories}
      end
  end


private

  def story_params
    params.require(:story).permit(:beginning)
  end


end
