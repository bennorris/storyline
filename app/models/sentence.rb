class Sentence < ApplicationRecord
  belongs_to :story
  belongs_to :user

  validates :content, presence: true
  validates :content, length: { maximum: 100 }
end
