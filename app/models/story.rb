class Story < ApplicationRecord
  belongs_to :user
  has_many :story_users
  has_many :sentences
  has_many :users, through: :sentences
  has_many :users, through: :story_users

  validates :content, presence: true
  validates :content, length: { maximum: 100 }

 def all_contributors
   users = {}
   self.sentences.each do |sentence|
     name = User.find_by_id(sentence.user_id)
     contribution = Sentence.find_by_id(sentence.id)
     users[name] = contribution
   end
  users
end

end
