class TodoistItemService
  TODOIST_URL = "https://api.todoist.com/sync/v8/sync"
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
        commands: [{
          args: { id: @item.todoist_id.to_i },
          type: TodoistItemService::ITEM_COMPLETE,
          uuid: uuid,
        }].to_json.gsub(' ', '')
      },
    }
  end

  def uuid
    SecureRandom.uuid
  end
end
