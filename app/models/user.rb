class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :name, presence: true

  mount_uploader :icon, IconUploader

  has_many :posts
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  def favorite_find(post_id)
    favorites.where(post_id: post_id).exists?
  end
end
