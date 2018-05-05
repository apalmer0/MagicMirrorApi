class TodoistItemService
  TODOIST_URL = "https://todoist.com/api/v7/sync"
  ITEM_COMPLETE = "item_complete"

  def initialize(item)
    @item = item
  end

  def self.complete(item)
    new(item).complete
  end

  def complete
    @item.transaction do
      complete_todoist_item
      @item.complete!
    end
  end

  private

  def complete_todoist_item
    HTTParty.post(TODOIST_URL, options)
  end

  def options
    {
      body: {
        token: ENV["TODOIST_KEY"],
        commands: "[{ \"type\": \"#{ITEM_COMPLETE}\", \"uuid\": \"#{uuid}\", \"args\": { \"ids\": [ #{@item.todoist_id.to_i} ] } }]"
      },
    }
  end

  def uuid
    SecureRandom.uuid
  end
end
