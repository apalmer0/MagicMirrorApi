require 'rails_helper'

describe "Items API" do
  describe "POST /items" do
    item_added_params = JSON.parse(
      File.read("spec/fixtures/todoist_events/item_added.rb")
    )
    item_deleted_params = JSON.parse(
      File.read("spec/fixtures/todoist_events/item_deleted.rb")
    )
    item_updated_params = JSON.parse(
      File.read("spec/fixtures/todoist_events/item_updated.rb")
    )
    item_completed_params = JSON.parse(
      File.read("spec/fixtures/todoist_events/item_completed.rb")
    )
    item_uncompleted_params = JSON.parse(
      File.read("spec/fixtures/todoist_events/item_uncompleted.rb")
    )

    context "when adding an item" do
      it "creates an item" do
        expect(Item.count).to eq 0

        post "/api/items", params: item_added_params

        expect(Item.count).to eq 1
        expect(Item.first.content).to eq "new todo item!"
        expect(Item.first.user_id).to eq "1234567"
        expect(response).to have_http_status :ok
      end
    end

    context "when deleting an item" do
      it "finds and deletes the correct item" do
        deleted_item = Item.create!(
          todoist_id: "1000000003",
          content: "delete this!"
        )
        kept_item = Item.create!(
          todoist_id: "12345",
          content: "don't delete this."
        )

        expect(Item.count).to eq 2

        post "/api/items", params: item_deleted_params

        expect(Item.count).to eq 1
        expect(Item.first).to eq(kept_item)
        expect { deleted_item.reload }.to raise_exception(ActiveRecord::RecordNotFound)
        expect(response).to have_http_status :ok
      end
    end

    context "when updating an item" do
      it "finds and updates the correct item" do
        item = Item.create!(
          todoist_id: "1000000004",
          content: "old"
        )

        post "/api/items", params: item_updated_params

        expect(item.reload.content).to eq "updated content"
        expect(response).to have_http_status :ok
      end
    end

    context "when completing an item" do
      it "finds and marks the correct item as complete" do
        item = Item.create!(
          todoist_id: "1000000002",
          content: "foo",
          status: "incomplete",
        )

        post "/api/items", params: item_completed_params

        expect(item.reload).to be_complete
        expect(response).to have_http_status :ok
      end
    end

    context "when uncompleting an item" do
      it "finds and marks the correct item as incomplete" do
        item = Item.create!(
          todoist_id: "1000000002",
          content: "foo",
          status: "complete",
        )

        post "/api/items", params: item_uncompleted_params

        expect(item.reload).to be_incomplete
        expect(response).to have_http_status :ok
      end
    end
  end

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
        create :item, :tomorrow

        get "/api/items?due=today"
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
