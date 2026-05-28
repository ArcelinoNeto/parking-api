require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it { is_expected.to have_many(:payments).dependent(:destroy) }
  it { is_expected.to define_enum_for(:status).with_values(active: 0, finished: 1, cancelled: 2) }
  it { is_expected.to validate_presence_of(:plate) }
  it { is_expected.to validate_presence_of(:status) }
end
