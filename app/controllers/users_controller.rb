require 'pry'

class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def welcome
  end

  def index
    @user = current_user
  end

  def create
    binding.pry
  end

end
