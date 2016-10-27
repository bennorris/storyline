class UpvotesController < ApplicationController

  def create
    @upvote = Upvote.new(user_id: current_user.id, sentence_id: params[:sentence_id])
    @story = Story.find_by_id(params[:story_id])
    if @upvote.save
      redirect_to story_path(@story), :flash => { :success => "Thanks for voting!" }
    else
      redirect_to story_path(@story), :flash => { :error => "Sorry, there was a problem with your vote." }
    end
  end




end
