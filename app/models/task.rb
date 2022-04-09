class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 150 }
  validates :description, presence: true

  belongs_to :user 
  belongs_to :pair 

  enum status: {未着手:0, 着手中:1, 完了:2}
end
