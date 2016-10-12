class Story < ApplicationRecord
  belongs_to :user
  has_many :story_users
  has_many :users, through: :story_users

end
