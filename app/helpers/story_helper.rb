module StoryHelper

  def any_flash_messages?
    if flash[:success].present?
      flash[:success]
    elsif flash[:error].present?
      flash[:error]
    end
  end

  def has_upvotes?(story)
    if story.unique_upvotes.empty?
      return "None, yet"
    else
      story.unique_upvotes.to_sentence
    end
  end

end
