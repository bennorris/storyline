class StorySerializer < ActiveModel::Serializer
  attributes :id, :user_id, :full_story, :beginning
  has_many :upvotes
end
