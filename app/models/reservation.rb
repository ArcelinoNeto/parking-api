class Reservation < ApplicationRecord
    validates_presence_of :plate, on: :create
    validates_presence_of :status, on: :create
end
