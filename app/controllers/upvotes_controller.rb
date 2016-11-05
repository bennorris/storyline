class UpvotesController < ApplicationController

  def create
    @story = Story.find_by_id(params[:story_id])
    @upvote = Upvote.new

    if params[:story_id] && !params[:sentence_id] #checking if its a story upvote or sentence upvote

      if Upvote.all.select {|vote| vote.user_id == current_user.id && vote.upvotable_id == params[:story_id].to_i && vote.upvotable_type == "Story" }.empty? #making sure user hasnt already voted
        @upvote = Upvote.new(user_id: current_user.id, upvotable_id: params[:story_id], upvotable_type: "Story")
        @upvote.save
        redirect_to story_path(@story), :flash => { :success => "Thanks for voting!" }
      else
        redirect_to story_path(@story), :flash => { :error => "Sorry, there was a problem with your vote." }
      end
    elsif params[:story_id] && params[:sentence_id]

      if Upvote.all.select {|vote| vote.user_id == current_user.id && vote.upvotable_id == params[:sentence_id].to_i && vote.upvotable_type == "Sentence" }.empty?
        @upvote = Upvote.new(user_id: current_user.id, upvotable_id: params[:sentence_id], upvotable_type: "Sentence")
        @upvote.save
        redirect_to story_path(@story), :flash => { :success => "Thanks for voting!" }
      else
        redirect_to story_path(@story), :flash => { :error => "Sorry, there was a problem with your vote." }
      end
    end


  end




end
