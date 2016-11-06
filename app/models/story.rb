class Story < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :sentences
  has_many :upvotes, :as => :upvotable
  has_many :users, through: :sentences, :foreign_key => "user_id"


  validates :beginning, presence: true
  validates :beginning, length: { maximum: 100 }

 def all_contributors
   users = {}
   self.sentences.each do |sentence|
     name = User.find_by_id(sentence.user_id)
     contribution = Sentence.find_by_id(sentence.id)
     users[name] = contribution
   end
  users
end

def already_voted_story?
  self.upvotes.include?(Upvote.find_by(user_id: yield, upvotable_id: self.id, upvotable_type: "Story"))
end


  def all_upvotes
    users = []
    self.upvotes.each do |vote|
        user = User.find_by_id(vote.user_id)

        if user && user.username
          users << user.username
        elsif user && user.email
          users << user.email
        end
      end

    self.sentences.each do |sentence|
      sentence.upvotes.each do |vote|
        user = User.find_by_id(vote.user_id)
        if user && user.username
          users << user.username
        elsif user && user.email
          users << user.email
        end
      end
    end
    users
  end

  def unique_upvotes
    all_upvotes.uniq
  end

  def last_to_post?(user)
    if self.sentences.size > 0
      self.sentences.last.user == user
    else
      self.user == user
    end

  end

  def self.all_content(user)
    content = []
    self.all.map do |story|
      content << [story.full_story, story.id, story.last_to_post?(user)]
    end
    content
  end


end
