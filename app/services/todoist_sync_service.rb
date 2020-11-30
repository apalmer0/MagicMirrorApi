class TodoistSyncService
  TODOIST_URL = "https://api.todoist.com/sync/v8/sync"
  RESOURCE_TYPE = "items"

  def self.sync
    new().sync
  end

  def sync
    todoist_response = fetch_todoist_items
    if todoist_response["items"].present?
      todoist_response["items"].each do |item|
        new_item = Item.find_or_initialize_by(todoist_id: item["id"])

        new_item.update(
          content: item["content"],
          due: save_in_eastern(item),
          status: item["checked"],
          todoist_id: item["id"],
          user_id: item["user_id"],
        )

        new_item.save!
      end
    end
  end

  def fetch_todoist_items
    HTTParty.post(TODOIST_URL, options)
  end

  def options
    {
      body: {
        token: ENV["TODOIST_KEY"],
        sync_token: "*",
        resource_types: "[\"#{RESOURCE_TYPE}\"]"
      }
    }
  end

  def save_in_eastern(item)
    item.dig("due", "date").to_datetime
  end

  def is_recurring?(item)
    item.dig("due", "is_recurring")
  end
end
