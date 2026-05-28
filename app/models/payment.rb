class Payment < ApplicationRecord
  belongs_to :reservation

  validates :value, presence: true, numericality: { greater_than: 0 }
end
