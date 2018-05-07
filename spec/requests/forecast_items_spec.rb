require 'rails_helper'

describe "Forecast Items API", type: :request do
  describe "GET /forecast_items" do
    it "returns all ForecastItems" do
      create_list :forecast_item, 2

      get "/api/forecast_items"
      parsed_response = JSON.parse(response.body)

      expect(parsed_response.length).to eq 2
    end
  end
end
