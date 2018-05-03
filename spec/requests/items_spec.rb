require 'rails_helper'

describe "Items API", type: :request do
  describe "GET /items" do
    context "when requesting all items" do
      it "returns all items" do
        item_1 = create :item
        item_2 = create :item

        get "/api/items"
        parsed_response = JSON.parse(response.body)

        expect(parsed_response.length).to eq 2
        parsed_response.first.tap do |elem|
          expect(elem["id"]).to eq(item_1.id)
          expect(elem["content"]).to eq(item_1.content)
          expect(elem["todoist_id"]).to eq(item_1.todoist_id)
          expect(elem["status"]).to eq(item_1.status)
          expect(elem["user_id"]).to eq(item_1.user_id)
        end
        parsed_response.last.tap do |elem|
          expect(elem["id"]).to eq(item_2.id)
          expect(elem["content"]).to eq(item_2.content)
          expect(elem["todoist_id"]).to eq(item_2.todoist_id)
          expect(elem["status"]).to eq(item_2.status)
          expect(elem["user_id"]).to eq(item_2.user_id)
        end
      end
    end

    context "when requesting a given user's items" do
      it "returns all items for that user" do
        item_1 = create :item, user_id: 'abc123'
        create :item, user_id: 'def456'

        get "/api/items?user_id=abc123"
        parsed_response = JSON.parse(response.body)

        expect(parsed_response.length).to eq 1
        parsed_response.first.tap do |elem|
          expect(elem["id"]).to eq(item_1.id)
          expect(elem["content"]).to eq(item_1.content)
          expect(elem["todoist_id"]).to eq(item_1.todoist_id)
          expect(elem["status"]).to eq(item_1.status)
          expect(elem["user_id"]).to eq(item_1.user_id)
        end
      end
    end

    context "when requesting today's items" do
      it "returns all items due today" do
        item_1 = create :item, :today
        overdue_item = create :item, :yesterday
        create :item, :tomorrow

        get "/api/items?due=today"
        parsed_response = JSON.parse(response.body)

        expect(parsed_response.length).to eq 2
        parsed_response.first.tap do |elem|
          expect(elem["id"]).to eq(item_1.id)
          expect(elem["content"]).to eq(item_1.content)
          expect(elem["todoist_id"]).to eq(item_1.todoist_id)
          expect(elem["status"]).to eq(item_1.status)
          expect(elem["user_id"]).to eq(item_1.user_id)
        end
        parsed_response.last.tap do |elem|
          expect(elem["id"]).to eq(overdue_item.id)
          expect(elem["content"]).to eq(overdue_item.content)
          expect(elem["todoist_id"]).to eq(overdue_item.todoist_id)
          expect(elem["status"]).to eq(overdue_item.status)
          expect(elem["user_id"]).to eq(overdue_item.user_id)
        end
      end
    end

    context "when requesting completed items" do
      it "returns all completed items" do
        complete_item = create :item, :complete
        create :item, :incomplete

        get "/api/items?status=complete"
        parsed_response = JSON.parse(response.body)

        expect(parsed_response.length).to eq 1
        parsed_response.first.tap do |elem|
          expect(elem["id"]).to eq(complete_item.id)
          expect(elem["content"]).to eq(complete_item.content)
          expect(elem["todoist_id"]).to eq(complete_item.todoist_id)
          expect(elem["status"]).to eq(complete_item.status)
          expect(elem["user_id"]).to eq(complete_item.user_id)
        end
      end
    end

    context "when requesting a given user's items for today" do
      it "returns all items due today for that user" do
        item_1 = create :item, :today, user_id: 'abc123'
        create :item, :today, user_id: 'def456'
        create :item, :tomorrow, user_id: 'abc123'
        create :item, :tomorrow, user_id: 'def456'

        get "/api/items?due=today&user_id=abc123"
        parsed_response = JSON.parse(response.body)

        expect(parsed_response.length).to eq 1
        parsed_response.first.tap do |elem|
          expect(elem["id"]).to eq(item_1.id)
          expect(elem["content"]).to eq(item_1.content)
          expect(elem["todoist_id"]).to eq(item_1.todoist_id)
          expect(elem["status"]).to eq(item_1.status)
          expect(elem["user_id"]).to eq(item_1.user_id)
        end
      end
    end
  end
end
