class Upvote < ApplicationRecord
  belongs_to :upvotable, :polymorphic => true
  validates :upvotable_id, presence: true





end
