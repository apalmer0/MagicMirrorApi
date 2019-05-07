module Api
  class TriviaItemsController < ApplicationController
    def index
      render json: trivia_items_collection, status: :ok, each_serializer: TriviaItemsSerializer
    end

    def update
      TriviaResponseService.handle_response(answer)
    end

    private

    def answer
      params["content"]
    end

    def trivia_items_collection
      @trivia = TriviaItem.all
      @trivia = @trivia.order("id desc").limit(params["limit"]) if limit?
      @trivia
    end

    def limit?
      params["limit"].present?
    end
  end
end
