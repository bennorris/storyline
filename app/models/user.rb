class User < ApplicationRecord
  has_many :stories
  has_many :sentences
  has_many :upvotes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable


end
