class StoriesController < ApplicationController
  before_action :authenticate_user!

  def create
    @story = Story.new(story_params)
    @story.user_id = current_user.id
    @story.full_story = @story.beginning

    if @story.save
      render json: @story, status: 201
    else
      redirect_to user_path(current_user), :flash => { :error => "Story cannot be blank and must be under 100 characters." }
    end
  end


  def show
    @story = Story.find_by_id(params[:id])
    @sentence = Sentence.new
    respond_to do |f|
      f.html {render :show}
      f.json {render json: @story}
    end
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
      @stories = current_user.stories
      respond_to do |f|
        f.html {render :index}
        f.json {render json: @stories}
      end
  end

  def all_stories
    @stories = Story.all
    respond_to do |f|
      f.json {render json: @stories}
    end
  end


private

  def story_params
    params.require(:story).permit(:beginning)
  end


end
