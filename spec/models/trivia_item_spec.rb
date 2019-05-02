require "rails_helper"

RSpec.describe TriviaItem, type: :model do
  describe "validations" do
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:answer) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:value) }
    it { should define_enum_for(:status).with_values([:unanswered, :incorrect, :correct]) }
  end

  describe "set_defaults" do
    it "is created as 'unanswered'" do
      item = TriviaItem.new

      expect(item).to be_unanswered
    end
  end
end
