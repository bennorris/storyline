class Sentence < ApplicationRecord
  belongs_to :story
  belongs_to :user
  has_many :upvotes 

  validates :content, presence: true
  validates :content, length: { maximum: 100 }
end
