class TodoistWebhookController < ApplicationController
  def create
    if TodoistWebhookService.handle_event(event_name, event_data)
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
