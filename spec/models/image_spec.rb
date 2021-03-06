require 'rails_helper'

RSpec.describe Image, type: :model do
  describe "validations" do
    it { should validate_presence_of(:url) }
    it { should define_enum_for(:image_source).with_values({google: 1}) }
    it { should define_enum_for(:status).with_values([:active, :inactive]) }
  end

  describe "set_defaults" do
    it "is created as 'active'" do
      image = Image.new

      expect(image).to be_active
    end
  end
end
