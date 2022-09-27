class Payment < ApplicationRecord
  validates_presence_of :value
  belongs_to :reservation
end
