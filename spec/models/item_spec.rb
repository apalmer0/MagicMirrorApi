require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "set_defaults" do
    it "is created with pending status" do
      item = Item.new()

      expect(item).to be_incomplete
    end

    it "is created with a due date of today" do
      item = Item.new()

      expect(item).to be_due_today
    end
  end

  describe "scopes" do
    describe ".due_today" do
      it "returns all items that are due today" do
        item_1 = create(:item, :today)
        create(:item, :tomorrow)

        expect(Item.due_today).to match_array([ item_1 ])
      end
    end

    describe ".for_user(id)" do
      it "returns all items that belong to the given user" do
        item_1 = create(:item, user_id: 'abc123')
        create(:item, user_id: 'def456')

        expect(Item.for_user('abc123')).to match_array([ item_1 ])
      end
    end
  end
end
