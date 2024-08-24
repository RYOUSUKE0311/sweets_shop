class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :content, presence: true, length: { maximum: 500 }
  
  def self.search(keyword)
    if keyword.present?
      self.where('content LIKE ?', "%#{keyword}%")
    end
  end
end
