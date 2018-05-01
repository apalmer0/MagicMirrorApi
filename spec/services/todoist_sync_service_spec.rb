require "rails_helper"

describe TodoistSyncService do
  describe ".sync" do
    response = JSON.parse(
      File.read("spec/fixtures/todoist_events/sync_response.rb")
    )
    before do
      allow(HTTParty).to receive(:post).and_return(response)
    end

    it "makes an HTTP request to Todoist" do
      TodoistSyncService.sync()

      expect(HTTParty).to have_received(:post)
    end

    it "creates a new Item for each item returned" do
      expect { TodoistSyncService.sync() }
        .to change { Item.count }
        .from(0).to(3)
    end

    it "creates items with the correct attributes" do
      TodoistSyncService.sync()

      Item.last.tap do |item|
        expect(item.content).to eq "Email quads"
        expect(item.user_id).to eq "1234567"
        expect(item.todoist_id).to eq "1000000003"
        expect(item.status).to eq "incomplete"
      end
    end
  end
end
