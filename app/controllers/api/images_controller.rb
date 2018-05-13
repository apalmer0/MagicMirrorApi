module Api
  class ImagesController < ApplicationController
    def index
      render json: images_collection, status: :ok
    end

    private

    def images_collection
      @images = Image.active
      @images = @images.google if google_results?
      @images = @images.twilio if twilio_results?
      @images
    end

    def google_results?
      params["image_source"] == "google"
    end

    def twilio_results?
      params["image_source"] == "twilio"
    end
  end
end
