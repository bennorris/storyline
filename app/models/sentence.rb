class Sentence < ApplicationRecord
  belongs_to :story
  belongs_to :user
  has_many :upvotes, :as => :upvotable

  validates :content, presence: true
  validates :content, length: { maximum: 100 }

  def already_voted?
    self.upvotes.include?(Upvote.find_by(user_id: yield, upvotable_id: self.id, upvotable_type: "Sentence"))
  end

  def sentence_upvotes
    users = []
    self.upvotes.each do |vote|
        user = User.find_by_id(vote.user_id)
        users << user.username
      end
      users
  end





end
