class User < ApplicationRecord
  has_many :stories
  has_many :story_users
  has_many :sentences
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable


end
