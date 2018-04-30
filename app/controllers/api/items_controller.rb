module Api
  class ItemsController < ApplicationController
    def create
      if item_added?
        Item.create(
          status: "incomplete",
          content: item_content,
          due: due_date,
          todoist_id: todoist_id,
        )
      elsif item_deleted?
        item&.delete
      elsif item_updated?
        item&.update(content: item_content)
      elsif item_completed?
        item.complete!
      elsif item_uncompleted?
        item.incomplete!
      end

      head :ok
    end

    private

    def item
      @item ||= Item.find_by(todoist_id: todoist_id)
    end

    def todoist_id
      event_data["id"].to_s
    end

    def due_date
      event_data["due_date_utc"]
    end

    def item_content
      event_data["content"]
    end

    def completed
      event_data["checked"]
    end

    def item_added?
      params["event_name"] == "item:added"
    end

    def item_deleted?
      params["event_name"] == "item:deleted"
    end

    def item_updated?
      params["event_name"] == "item:updated"
    end

    def item_completed?
      params["event_name"] == "item:completed"
    end

    def item_uncompleted?
      params["event_name"] == "item:uncompleted"
    end

    def event_data
      params["event_data"]
    end
  end
end
