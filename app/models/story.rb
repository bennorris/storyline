class Story < ApplicationRecord
  belongs_to :user
  has_many :users, through: :story_users 

end
