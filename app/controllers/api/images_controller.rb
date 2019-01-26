module Api
  class ImagesController < ApplicationController
    def index
      render json: images_collection, status: :ok
    end

    private

    def images_collection
      @images = Image.active
      @images = @images.google.queued if google_results?
      @images
    end

    def google_results?
      params["image_source"] == "google"
    end
  end
end
