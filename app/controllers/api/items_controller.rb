module Api
  class ItemsController < ApplicationController
    def index
      render json: items_collection, status: :ok
    end

    private

    def items_collection
      @items = Item.all
      @items = @items.due_today if due_today?
      @items = @items.for_user(params["user_id"]) if for_user?
      @items = @items.complete if completed?
      @items
    end

    def due_today?
      params["due"] == "today"
    end

    def for_user?
      params["user_id"].present?
    end

    def completed?
      params["status"] == "complete"
    end
  end
end
