class Genre < ApplicationRecord
  has_many :stories
  belongs_to :user
  validates :name, presence: true


    def stories_attributes=(attributes)
      new_story = self.stories.build
      attributes.each do | key, value |
        new_story.send("#{key}=", value)
      end
      new_story.full_story = new_story.beginning
    end

end
