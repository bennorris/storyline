class User < ApplicationRecord
  has_many :stories
  has_many :sentences
  has_many :upvotes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]


 def self.from_omniauth(auth)
   
  where(uid: auth.uid).first_or_create do |user|
    user.uid = auth.uid
    user.email = auth.info.email
    user.username = auth.info.name
    user.password = Devise.friendly_token[0,20]
    user.password_confirmation = user.password
   end
 end

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
