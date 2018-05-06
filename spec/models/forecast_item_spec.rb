require 'rails_helper'

RSpec.describe ForecastItem, type: :model do
  subject { build(:forecast_item) }

  describe "validations" do
    it { should validate_presence_of(:unix_time) }
    it { should validate_presence_of(:precip_chance) }
    it { should validate_presence_of(:temperature) }
    it { should validate_uniqueness_of(:unix_time).case_insensitive }
  end
end
