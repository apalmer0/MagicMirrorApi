module Api
  class ItemsController < ApplicationController
    def create
      if TodoistEventService.handle_event(event_name, event_data)
        head :ok
      end
    end

    def index
      render json: items_collection, status: :ok
    end

    private

    def items_collection
      @items = Item.all
      @items = @items.where(due: DateTime.now.end_of_day.utc) if params["due"] == "today"
      @items = @items.where(user_id: params["user_id"]) if params["user_id"].present?
      @items
    end

    def event_name
      params["event_name"]
    end

    def event_data
      params["event_data"]
    end

    def due_today?
      params["due"] == "today"
    end

    def for_user?
      params["user_id"].present?
    end

    def user_items
      Item.where(user_id: params["user_id"])
    end
  end
end
