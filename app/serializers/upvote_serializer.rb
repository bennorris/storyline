class UpvoteSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :upvotable_id, :upvotable_type
  belongs_to :story
end
