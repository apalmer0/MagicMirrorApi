require "rails_helper"

RSpec.describe "Trivia Item Stats API", type: :request do
  describe "GET /stats" do
    before do
      create(:trivia_item, :correct, updated_at: Date.today)
      create(:trivia_item, :incorrect, updated_at: Date.today - 7.days)
    end

    it "returns a hash of stats" do
      get "/api/trivia_item_stats"
      parsed_response = JSON.parse(response.body)

      expect(parsed_response).to eq(
        "today" => 1,
        "all_time" => 0.5,
      )
    end
  end
end
