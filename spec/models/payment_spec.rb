require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { is_expected.to belong_to :reservation }
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_numericality_of(:value).is_greater_than(0) }
end
