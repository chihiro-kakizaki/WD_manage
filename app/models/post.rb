class Post < ApplicationRecord
  validates :content, presence: true

  enum category: {
                  dress: 0,
                  food: 1,
                  flower: 2 
                }
  
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :favorites, dependent: :destroy
end
