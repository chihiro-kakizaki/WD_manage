class Pair < ApplicationRecord
  after_create_commit :create_assign

  enum season: { 春:0, 夏:1, 秋:2, 冬:3 }

  has_many :assigns
  has_many :users, through: :assigns

  def create_assign
    assigns.create(user_id: owner_id)
  end
end
