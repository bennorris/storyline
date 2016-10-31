class GenresController < ApplicationController

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.find_or_create_by(name: params[:genre][:name])
    @story = @genre.stories.build(beginning: params[:story][:beginning], user_id: current_user.id)
    @story.full_story = @story.beginning
    
    if @genre.save && @story.save
      redirect_to user_path(current_user), :flash => { :success => "Success! You can find your story below, in the 'Your Stories' section." }
    else
      redirect_to user_path(current_user), :flash => { :error => "Story cannot be blank and must be under 100 characters.", :genre_error => "Genre must have a name." }
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
