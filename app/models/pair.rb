class Pair < ApplicationRecord

  enum season: { 春:0, 夏:1, 秋:2, 冬:3 }

  has_many :assigns, dependent: :destroy
  has_many :users, through: :assigns , dependent: :destroy
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  
  has_many :tasks, dependent: :destroy


end
