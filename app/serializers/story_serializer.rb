class StorySerializer < ActiveModel::Serializer
  attributes :id, :user_id, :full_story, :beginning
  has_many :upvotes
  has_many :sentences
end
