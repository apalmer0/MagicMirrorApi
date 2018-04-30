class TodoistEventService
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
    if item_added?
      create_item!
    elsif item_deleted?
      item&.delete
    elsif item_updated?
      item&.update(content: item_content)
    elsif item_completed?
      item.complete!
    elsif item_uncompleted?
      item.incomplete!
    end
  end

  private

  def create_item!
    Item.create(
      status: "incomplete",
      content: item_content,
      due: due_date,
      todoist_id: todoist_id,
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

  def item_added?
    @event_name == ITEM_ADDED
  end

  def item_deleted?
    @event_name == ITEM_DELETED
  end

  def item_updated?
    @event_name == ITEM_UPDATED
  end

  def item_completed?
    @event_name == ITEM_COMPLETED
  end

  def item_uncompleted?
    @event_name == ITEM_UNCOMPLETED
  end
end
