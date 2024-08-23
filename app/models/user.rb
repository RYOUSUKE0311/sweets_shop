class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 50 }

  has_many :posts, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  has_many :comments, dependent: :destroy
  
  def favorite(post)
    self.favorites.find_or_create_by(post_id: post.id)
  end
  
  def unfavorite(post)
    self.favorites.find_by(post_id: post.id)&.destroy
  end
  
  def favorite?(post)
    self.favorite_posts.include?(post)
  end
  
  def follow(user)
    self.relationships.find_or_create_by(followed_id: user.id)
  end
  
  def unfollow(user)
    self.relationships.find_by(followed_id: user.id)&.destroy
  end
  
  def following?(user)
    self.followings.include?(user)
  end
end
