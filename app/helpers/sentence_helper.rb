module SentenceHelper

  def current_sentence_upvotes(upvotes)
    if upvotes.empty?
      return "None, yet."
    else
      upvotes.to_sentence
    end
  end

  def style_created(date)
    date.in_time_zone('Eastern Time (US & Canada)').strftime("%B %e, %Y at %I:%M %p")
  end

end
