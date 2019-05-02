module Api
  class TriviaItemsController < ApplicationController
    def index
      render json: trivia_items_collection, status: :ok
    end

    private

    def trivia_items_collection
      @trivia = TriviaItem.all
      @trivia = @trivia.unanswered if unanswered?
      @trivia = @trivia.order("id desc").limit(params["limit"]) if limit?
      @trivia
    end

    def unanswered?
      params["status"] == "unanswered"
    end

    def limit?
      params["limit"].present?
    end
  end
end
