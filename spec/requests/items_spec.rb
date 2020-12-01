require 'rails_helper'

describe "Items API", type: :request do
  describe "GET /items" do
    context "when requesting all items" do
      it "returns all items" do
        today = DateTime.current
        item_1 = create :item, due: today
        item_2 = create :item, due: today - 1.day

        get "/api/items"
        parsed_response = JSON.parse(response.body)

        expect(parsed_response.length).to eq 2
        parsed_response.first.tap do |elem|
          expect(elem["id"]).to eq(item_2.id)
          expect(elem["content"]).to eq(item_2.content)
          expect(elem["todoist_id"]).to eq(item_2.todoist_id)
          expect(elem["status"]).to eq(item_2.status)
          expect(elem["user_id"]).to eq(item_2.user_id)
        end
        parsed_response.last.tap do |elem|
          expect(elem["id"]).to eq(item_1.id)
          expect(elem["content"]).to eq(item_1.content)
          expect(elem["todoist_id"]).to eq(item_1.todoist_id)
          expect(elem["status"]).to eq(item_1.status)
          expect(elem["user_id"]).to eq(item_1.user_id)
        end
      end
    end

    context "when requesting a given user's items" do
      it "returns all items for that user" do
        item_1 = create :item, user_id: '1'
        create :item, user_id: '2'

        get "/api/items?user_id=1"
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
          expect(elem["id"]).to eq(overdue_item.id)
          expect(elem["content"]).to eq(overdue_item.content)
          expect(elem["todoist_id"]).to eq(overdue_item.todoist_id)
          expect(elem["status"]).to eq(overdue_item.status)
          expect(elem["user_id"]).to eq(overdue_item.user_id)
        end
        parsed_response.last.tap do |elem|
          expect(elem["id"]).to eq(item_1.id)
          expect(elem["content"]).to eq(item_1.content)
          expect(elem["todoist_id"]).to eq(item_1.todoist_id)
          expect(elem["status"]).to eq(item_1.status)
          expect(elem["user_id"]).to eq(item_1.user_id)
        end
      end
    end

    context "when requesting incomplete items" do
      it "returns all incomplete items" do
        incomplete_item = create :item, :incomplete
        create :item, :complete

        get "/api/items?status=incomplete"
        parsed_response = JSON.parse(response.body)

        expect(parsed_response.length).to eq 1
        parsed_response.first.tap do |elem|
          expect(elem["id"]).to eq(incomplete_item.id)
          expect(elem["content"]).to eq(incomplete_item.content)
          expect(elem["todoist_id"]).to eq(incomplete_item.todoist_id)
          expect(elem["status"]).to eq(incomplete_item.status)
          expect(elem["user_id"]).to eq(incomplete_item.user_id)
        end
      end
    end

    context "when requesting a given user's items for today" do
      it "returns all items due today for that user" do
        item_1 = create :item, :today, user_id: '1'
        create :item, :today, user_id: '2'
        create :item, :tomorrow, user_id: '1'
        create :item, :tomorrow, user_id: '2'

        get "/api/items?due=today&user_id=1"
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

  describe "PATCH /items" do
    before { allow(TodoistItemService).to receive(:complete) }

    context "when there's only one matching item" do
      it "calls the TodoistItemService with the correct item, regardless of case" do
        uppercase_content = "TEST"
        lowercase_content = "test"
        item_1 = create :item, content: uppercase_content
        params =
          {
            content: lowercase_content,
            item:  { content: lowercase_content },
          }

        put "/api/items", params: params

        expect(TodoistItemService).to have_received(:complete).with(item_1)
      end
    end

    context "when there's more than one matching item" do
      it "calls the TodoistItemService with the correct item" do
        content = "a man, a plan, a canal: panama"
        create :item, :incomplete, content: content, due: Date.current
        create :item, :complete, content: content, due: Date.current + 1.day
        create :item, :complete, content: content, due: Date.current - 1.day
        item = create :item, :incomplete, content: content, due: Date.current - 1.day

        params =
          {
            content: content,
            item:  { content: content },
          }

        put "/api/items", params: params

        expect(TodoistItemService).to have_received(:complete).with(item)
      end
    end
  end
end
