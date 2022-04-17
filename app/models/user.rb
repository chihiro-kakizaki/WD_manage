class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :name, presence: true

  mount_uploader :icon, IconUploader

  has_many :posts
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  has_one :assign, dependent: :destroy
  has_one :pair, foreign_key: :owner_id, dependent: :destroy

  has_many :tasks

  #has_one :assign_pair through: :assign

  def favorite_find(post_id)
    favorites.where(post_id: post_id).exists?
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲスト" 
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def self.guest_admin
    find_or_create_by!(email: 'guest_admin@example.com') do |user|
      user.name = "ゲスト管理者" 
      user.password = SecureRandom.urlsafe_base64
      user.admin = true
    end
  end
end
