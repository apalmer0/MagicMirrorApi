class TodoistSyncService
  TODOIST_URL = "https://todoist.com/api/v7/sync"
  RESOURCE_TYPE = "items"

  def self.sync
    new().sync
  end

  def sync
    todoist_response = fetch_todoist_items
    if todoist_response["items"].present?
      todoist_response["items"].each do |item|
        Item.where(todoist_id: item["id"]).first_or_create(
          content: item["content"],
          user_id: item["user_id"],
          todoist_id: item["id"],
          due: item["due_date_utc"],
          status: item["checked"],
        )
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
end
