require "rails_helper"

describe DarkSkyService do
  describe ".fetch_weather" do
    response = JSON.parse(
      File.read("spec/fixtures/dark_sky_responses/fetch_weather.rb")
    )
    before do
      allow(HTTParty).to receive(:get).and_return(response)
    end

    it "makes a get request to DarkSky" do
      DarkSkyService.fetch_weather

      expect(HTTParty).to have_received(:get).with(
        "https://api.darksky.net/forecast/#{ENV["DARK_SKY_KEY"]}/42.3736,-71.1097",
      )
    end

    context "when no ForecastItems exist" do
      it "creates a ForecastItem for each item returned in the 'hourly' response" do
        expect(ForecastItem.count).to eq 0

        DarkSkyService.fetch_weather

        expect(ForecastItem.count).to eq 49
        ForecastItem.last.tap do |item|
          expect(item["precip_chance"]).to eq 77
          expect(item["temperature"]).to eq 53
          expect(item["unix_time"]).to eq "1525784400"
        end
      end
    end

    context "when half of the ForecastItems exist" do
      it "creates a ForecastItem for each item returned in the 'hourly' response" do
        hours = [1525611600, 1525615200, 1525618800, 1525622400, 1525626000, 1525629600,
          1525633200, 1525636800, 1525640400, 1525644000, 1525647600, 1525651200,
          1525654800, 1525658400, 1525662000, 1525665600, 1525669200, 1525672800,
          1525676400, 1525680000, 1525683600, 1525687200, 1525690800, 1525694400,
          1525698000, 1525701600]

        hours.each do |hour|
          create :forecast_item, precip_chance: 100, temperature: 0, unix_time: hour
        end

        expect(ForecastItem.count).to eq 26

        DarkSkyService.fetch_weather

        expect(ForecastItem.count).to eq 49
        ForecastItem.first.tap do |item|
          expect(item["precip_chance"]).to eq 4
          expect(item["temperature"]).to eq 62
          expect(item["unix_time"]).to eq "1525611600"
        end
        ForecastItem.last.tap do |item|
          expect(item["precip_chance"]).to eq 77
          expect(item["temperature"]).to eq 53
          expect(item["unix_time"]).to eq "1525784400"
        end
      end
    end
  end
end
