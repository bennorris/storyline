require 'pry'

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
      @user_sentences = Sentence.all.select {|s| s.user == @user}
    else
      redirect_to user_path(current_user)
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
