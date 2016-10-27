class Sentence < ApplicationRecord
  belongs_to :story
  belongs_to :user
  has_many :upvotes

  validates :content, presence: true
  validates :content, length: { maximum: 100 }

  def already_voted?
    self.upvotes.include?(Upvote.find_by(user_id: yield, sentence_id: self.id))
  end


end
