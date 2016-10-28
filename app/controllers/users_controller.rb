class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def welcome
    if current_user
      redirect_to user_path(current_user)
    end
  end

  def index
    @user = current_user
  end

  def create
  end

  def show
    if current_user.id.to_i == params[:id].to_i
      @user = current_user
      @story = Story.new
      @all_stories = Story.all
      @user_stories = Story.all.select {|s| s.user == @user}
      @user_contributions = @user.sentences
    else
      redirect_to user_path(current_user)
    end
  end

  def stats
    @user = User.find_by_id(params[:id])
    @stories = @user.stories.size
    @sentences = @user.sentences.size
    @upvotes = @user.all_upvotes
  end



  def destroy
    session.clear
    redirect_to root_path
  end

end
