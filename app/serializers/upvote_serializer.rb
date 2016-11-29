class UpvoteSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :upvotable_id, :upvotable_type
end
