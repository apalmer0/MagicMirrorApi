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
        TodoistItemService::TODOIST_URL,
        {
          body: {
            token: ENV["TODOIST_KEY"],
            commands: "[{\"args\":{\"id\":#{item.todoist_id.to_i}},\"type\":\"item_complete\",\"uuid\":\"#{fake_uuid}\"}]"
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
