require "rails_helper"

describe TodoistItemService do
  describe ".complete" do
    fake_uuid = 'not-actually-unique-number'

    before do
      allow(HTTParty).to receive(:post)
      allow(SecureRandom).to receive(:uuid).and_return(fake_uuid)
    end

    it "makes a sync request to Todoist" do
      item = create :item
      TodoistItemService.complete(item)

      expect(HTTParty).to have_received(:post).with(
        "https://todoist.com/api/v7/sync",
        {
          body: {
            token: ENV["TODOIST_KEY"],
            commands: "[{ \"type\": \"item_complete\", \"uuid\": \"#{fake_uuid}\", \"args\": { \"ids\": [ #{item.todoist_id.to_i} ] } }]"
          }
        }
      )
    end

    it "marks the found item as complete" do
      item = create :item
      expect(item).to be_incomplete

      TodoistItemService.complete(item)

      expect(item).to be_complete
    end
  end
end
