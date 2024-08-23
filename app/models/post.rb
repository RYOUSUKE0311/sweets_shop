class Post < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 1000 }
  
  has_one_attached :image
  
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
end
