class Story < ApplicationRecord
  belongs_to :user
  has_many :sentences
  has_many :upvotes, :as => :upvotable
  has_many :users, through: :sentences, :foreign_key => "user_id"


  validates :beginning, presence: true
  validates :beginning, length: { maximum: 100 }

 def all_contributors
   users = {}
   self.sentences.each do |sentence|
     name = User.find_by_id(sentence.user_id)
     contribution = Sentence.find_by_id(sentence.id)
     users[name] = contribution
   end
  users
end

def already_voted_story?
  self.upvotes.include?(Upvote.find_by(user_id: yield, upvotable_id: self.id, upvotable_type: "Story"))
end


end
