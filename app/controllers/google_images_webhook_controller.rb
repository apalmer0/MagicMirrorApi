class GoogleImagesWebhookController < ApplicationController
  def create
    if GoogleImagesService.fetch_images(search_term)
      head :ok
    end
  end

  private

  def search_term
    strong_params["query"]
  end

  def strong_params
    params.permit(:query, :google_images_webhook)
  end
end
