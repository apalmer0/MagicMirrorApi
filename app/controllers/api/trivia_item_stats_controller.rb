module Api
  class TriviaItemStatsController < ApplicationController
    def index
      render json: stats, status: :ok
    end

    private

    def stats
      {
        today: today,
        all_time: all_time,
      }
    end

    def today
      TriviaItem.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).group(:status).count
    end

    def all_time
      TriviaItem.group(:status).count
    end
  end
end
