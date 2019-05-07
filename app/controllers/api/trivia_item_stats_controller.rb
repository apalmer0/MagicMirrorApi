module Api
  class TriviaItemStatsController < ApplicationController
    def index
      render json: stats, status: :ok
    end

    private

    def stats
      {
        today: percent_today,
        all_time: percent_all_time,
      }
    end

    def percent_today
      correct_today.count.to_f / (correct_today.count + incorrect_today.count).to_f
    end

    def percent_all_time
      correct.count.to_f / (correct.count + incorrect.count).to_f
    end

    def correct
      TriviaItem.correct
    end

    def incorrect
      TriviaItem.incorrect
    end

    def correct_today
      correct.where(answered_today)
    end

    def incorrect_today
      incorrect.where(answered_today)
    end

    def answered_today
      {
        updated_at: DateTime.current.beginning_of_day..DateTime.current.end_of_day
      }
    end
  end
end
