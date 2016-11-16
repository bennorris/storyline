class SentencesController < ApplicationController

  def new
    @story = Story.find_by_id(params[:story_id])
    if @story.last_to_post?(current_user)
      redirect_to user_path(current_user)
    end
    @sentence = Sentence.new
  end

  def create
    story = Story.find_by_id(params[:story_id])
    if !story.last_to_post?(current_user)
      new_sentence = story.sentences.build(sentence_params)
      new_sentence.user = current_user
        if new_sentence.save
          story.full_story = story.full_story + " " + new_sentence.content
          story.save
          redirect_to story_path(story)
        else
          redirect_to new_story_sentence_path, :flash => { :error => "Sentence cannot be blank and must be under 100 characters." }
        end
    else
      redirect_to user_path(current_user)
    end
  end

  def show
    @sentence = Sentence.find_by_id(params[:id])
    @user = User.find_by_id(@sentence.user_id)
    @created = @sentence.created_at
    @upvotes = @sentence.sentence_upvotes
  end

  def destroy
    sentence = Sentence.find_by_id(params[:id])
    story = Story.find_by(params[:story_id])
    story.full_story = story.full_story.gsub("#{sentence.content}", "")
    story.save
    sentence.destroy
    redirect_to user_path(current_user), :flash => { :deleted => "Successfully deleted post."}
  end

  def index
    @sentences = Sentence.all.select { |s| s.user_id == current_user.id}
    respond_to do |f|
      f.html {render :index }
      f.json {render json: @sentences}
    end
  end 



private

    def sentence_params
      params.require(:sentence).permit(:content)
    end

end
