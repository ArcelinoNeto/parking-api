class Reservation < ApplicationRecord
  has_many :payments, dependent: :destroy

  enum status: {
    active: 0,
    finished: 1,
    cancelled: 2
  }

  validates :plate, presence: true
  validates :status, presence: true
end
