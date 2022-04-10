class Pair < ApplicationRecord

  enum season: {
                spring:0, 
                summer:1,
                autumn:2,
                winter:3
                }

  has_many :assigns, dependent: :destroy
  has_many :users, through: :assigns , dependent: :destroy
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  
  has_many :tasks, dependent: :destroy


end
