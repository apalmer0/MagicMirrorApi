class TodoistWebhookService
  ITEM_ADDED = "item:added"
  ITEM_DELETED = "item:deleted"
  ITEM_UPDATED = "item:updated"
  ITEM_COMPLETED = "item:completed"
  ITEM_UNCOMPLETED = "item:uncompleted"

  def initialize(event_name, event_data)
    @event_name = event_name
    @event_data = event_data
  end

  def self.handle_event(event_name, event_data)
    new(event_name, event_data).handle_event
  end

  def handle_event
    case @event_name
    when ITEM_ADDED
      create_item!
    when ITEM_DELETED
      item&.delete
    when ITEM_UPDATED
      item&.update(content: item_content)
    when ITEM_COMPLETED
      item.complete!
    when ITEM_UNCOMPLETED
      item.incomplete!
    end
  end

  private

  def create_item!
    Item.create(
      content: item_content,
      due: due_date,
      todoist_id: todoist_id,
      user_id: user_id,
    )
  end

  def item
    @item ||= Item.find_by(todoist_id: todoist_id)
  end

  def todoist_id
    @event_data["id"].to_s
  end

  def due_date
    @event_data["due_date_utc"]
  end

  def item_content
    @event_data["content"]
  end

  def completed
    @event_data["checked"]
  end

  def user_id
    @event_data["user_id"]
  end
end
