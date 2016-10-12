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
    binding.pry
  end

  def show
    @user = current_user
    @story = Story.new
    @user_stories = Story.all.select {|s| s.user == @user}
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
