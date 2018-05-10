class TwilioWebhookController < ApplicationController
  def create
    if TwilioImageService.create_image!(image_params)
      head :ok
    end
  end

  private

  def image_params
    params.permit(:MediaUrl0, :From, :Body)
  end
end
