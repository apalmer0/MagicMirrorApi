require 'rails_helper'

RSpec.describe Image, type: :model do
  describe "validations" do
    it { should validate_presence_of(:url) }
    it { should define_enum_for(:image_source).with([:twilio, :google]) }
  end
end
