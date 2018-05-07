module Api
  class ForecastItemsController < ApplicationController
    def index
      render json: ForecastItem.all, status: :ok
    end
  end
end
