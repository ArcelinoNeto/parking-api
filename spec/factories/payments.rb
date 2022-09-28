FactoryBot.define do
  factory :payment do
    value { "10.25" }
    association(:reservation)
  end
end
