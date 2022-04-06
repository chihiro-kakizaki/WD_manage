class Post < ApplicationRecord
  validates :content, presence: true

  enum category: {衣装:0, 料理・ドリンク:1, 装花:2, BGM:3, 招待状:4 }
  
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :favorites, dependent: :destroy
end
