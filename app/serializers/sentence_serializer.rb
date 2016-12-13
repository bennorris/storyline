class SentenceSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :content, :story_id
  belongs_to :story
end
