class SentencesController < ApplicationController

  def new
    @story = Story.find_by_id(params[:story_id])
    @sentence = Sentence.new
  end

  def create
    story = Story.find_by_id(params[:story_id])
    new_sentence = story.sentences.build(sentence_params)
    new_sentence.user_id = current_user.id

    if new_sentence.save
      story.content = story.content + " " + new_sentence.content
      story.save
      redirect_to story_path(story)
    else
      redirect_to new_story_sentence_path, :flash => { :error => "Sentence cannot be blank and must be under 100 characters." }
    end
  end

  def show
    @sentence = Sentence.find_by_id(params[:id])
    @user = User.find_by_id(@sentence.user_id)
    @created = @sentence.created_at.in_time_zone('Eastern Time (US & Canada)').strftime("%B %e, %Y at %I:%M %p")
  end

  def destroy
    sentence = Sentence.find_by_id(params[:id])

    if sentence.also_story == true
      story = Story.find_by_id(sentence.story_id)
      story.destroy
    end
    sentence.destroy
    redirect_to user_path(current_user), :flash => { :deleted => "Successfully deleted post."}
  end



private

    def sentence_params
      params.require(:sentence).permit(:content)
    end

end
