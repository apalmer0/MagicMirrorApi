require 'rails_helper'

describe "Todoist Webhook", type: :request do
  describe "POST /todoist_webhook" do
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

        post "/todoist_webhook", params: item_added_params

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

        post "/todoist_webhook", params: item_deleted_params

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

        post "/todoist_webhook", params: item_updated_params

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

        post "/todoist_webhook", params: item_completed_params

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

        post "/todoist_webhook", params: item_uncompleted_params

        expect(item.reload).to be_incomplete
        expect(response).to have_http_status :ok
      end
    end
  end
end
