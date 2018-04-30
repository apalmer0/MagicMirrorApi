module Api
  class ItemsController < ApplicationController
    def create
      if TodoistEventService.handle_event(event_name, event_data)
        head :ok
      end
    end

    private

    def event_name
      params["event_name"]
    end

    def event_data
      params["event_data"]
    end
  end
end