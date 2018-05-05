module Api
  class ItemsController < ApplicationController
    def index
      render json: items_collection, status: :ok
    end

    def update
      TodoistItemService.complete(item)
    end

    private

    def item
      @item ||= Item.where('lower(content) = ?', item_content.downcase).incomplete.order(due: :asc).first
    end

    def items_collection
      @items = Item.all
      @items = @items.due_today if due_today?
      @items = @items.for_user(params["user_id"]) if for_user?
      @items = @items.incomplete if incomplete?
      @items
    end

    def due_today?
      params["due"] == "today"
    end

    def for_user?
      params["user_id"].present?
    end

    def incomplete?
      params["status"] == "incomplete"
    end

    def item_content
      params["content"]
    end
  end
end
