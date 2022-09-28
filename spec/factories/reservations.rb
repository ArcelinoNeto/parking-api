FactoryBot.define do
  factory :reservation do
    plate { Faker::Vehicle.license_plate }
    entry { Faker::Time.between_dates(from: Date.today, to: Date.today, period: :morning) }
    exit { Faker::Time.between_dates(from: Date.today, to: Date.today, period: :afternoon) }
    status { [0 , 1].sample }
  end
end
