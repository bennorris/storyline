class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :random_story

  def random_story
    Story.all.sample
  end
  
end
