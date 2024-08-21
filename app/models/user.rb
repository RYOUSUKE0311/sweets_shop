class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 50 }

  has_many :posts, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :fovorite_posts, through: :favorites, source: :post

  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  has_many :comments, dependent: :destroy
end
