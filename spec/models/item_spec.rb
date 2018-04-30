require 'rails_helper'

RSpec.describe Item, type: :model do
  it "is created with pending status" do
    item = Item.new()

    expect(item).to be_incomplete
  end
end
