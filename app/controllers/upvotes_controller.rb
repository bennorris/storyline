class UpvotesController < ApplicationController

  def create
    @story = Story.find_by_id(params[:story_id])

    if params[:story_id] && !params[:sentence_id]
      @upvote = Upvote.new(user_id: current_user.id, upvotable_id: params[:story_id], upvotable_type: "Story")
    elsif params[:story_id] && params[:sentence_id]
      @upvote = Upvote.new(user_id: current_user.id, upvotable_id: params[:sentence_id], upvotable_type: "Sentence")
    end

    if @upvote.save
      redirect_to story_path(@story), :flash => { :success => "Thanks for voting!" }
    else
      redirect_to story_path(@story), :flash => { :error => "Sorry, there was a problem with your vote." }
    end
  end




end
