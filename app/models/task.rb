class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 150 }
  validates :description, presence: true
  validates :expired_on, presence: true
  validates :status, presence: true

  belongs_to :user 
  belongs_to :pair 

  has_many :comments, dependent: :destroy

  scope :expire_asc, -> { order(expired_on: :asc) }
  scope :status_asc, -> { order(status: :asc) }

  enum status: { not_started: 0,
                 start: 1, 
                 completion: 2
                }
end
