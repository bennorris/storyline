class User < ApplicationRecord
  has_many :stories
  has_many :story_users
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
