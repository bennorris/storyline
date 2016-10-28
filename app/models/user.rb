class User < ApplicationRecord
  has_many :stories
  has_many :sentences
  has_many :upvotes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable


  def all_upvotes
    count = 0
    self.sentences.each do |sentence|
      count+= sentence.upvotes.size.to_i
    end
    self.stories.each do |story|
      count+=story.upvotes.size.to_i
    end
    count
  end



end
