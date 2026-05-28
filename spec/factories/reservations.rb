FactoryBot.define do
  factory :reservation do
    plate { "AAA-9999" }
    entry { Faker::Time.between_dates(from: Date.today, to: Date.today, period: :morning) }
    exit { Faker::Time.between_dates(from: Date.today, to: Date.today, period: :afternoon) }
    status { :active }
  end
end
