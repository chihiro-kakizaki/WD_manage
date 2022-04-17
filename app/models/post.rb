class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000 }

  enum category: {
                  dress: 0,
                  food: 1,
                  flower: 2 
                }
  
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
end
