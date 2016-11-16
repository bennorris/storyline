class StorySerializer < ActiveModel::Serializer
  attributes :id, :user_id, :full_story 
end
