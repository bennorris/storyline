class UpvotesController < ApplicationController

  def create
    @story = Story.find_by_id(params[:story_id])
    @upvote = Upvote.new

    if params[:story_id] && !params[:sentence_id]
      user_upvote(params[:story_id], "Story")
    elsif params[:story_id] && params[:sentence_id] 
      user_upvote(params[:sentence_id], "Sentence")
    end

  end

private

  def user_upvote(which_id, type)
    if Upvote.all.select {|vote| vote.user_id == current_user.id && vote.upvotable_id == which_id.to_i && vote.upvotable_type == "#{type}" }.empty? #making sure user hasn't already voted
      @upvote = Upvote.new(user_id: current_user.id, upvotable_id: which_id, upvotable_type: "#{type}")
      @upvote.save
      redirect_to story_path(@story), :flash => { :success => "Thanks for voting!" }
    else
      redirect_to story_path(@story), :flash => { :error => "Sorry, there was a problem with your vote." }
    end
  end



end
