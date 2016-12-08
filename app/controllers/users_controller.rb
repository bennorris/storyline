class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    if current_user_page
      @story = Story.new
      respond_to do |f|
        f.json {render json: current_user.stories}
        f.html {render :show}
      end
    else
      redirect_to user_path(current_user)
    end

  end

  def index
    @user = current_user
    @stories = @user.stories
    respond_to do |f|
      f.html {render :index}
      f.json {render json: @stories}
    end
  end

  def stats
    @user = User.find_by_id(params[:id])
    @stories = @user.stories.size
    @sentences = @user.sentences.size
    @upvotes = @user.all_upvotes
  end

  def edit
    if current_user_page
      @user = current_user
    else
      redirect_to edit_user_path(current_user)
    end
  end

  def update
    if current_user_page
      @user = current_user
      @user.username = params[:user][:username]
        if @user.save
          redirect_to user_stats_path(@user)
        else
          redirect_to edit_user_path(@user)
        end
    else
      redirect_to user_stats_path(current_user)
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  def get_id
    respond_to do |f|
      f.json {render json: current_user.id}
    end
  end

private

  def current_user_page
    current_user.id.to_i == params[:id].to_i
  end


end
