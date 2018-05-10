module Api
  class ImagesController < ApplicationController
    def index
      render json: Image.all, status: :ok
    end
  end
end
