require "rails_helper"

describe DarkSkyService do
  describe ".fetch_weather" do
    let(:response) do
      JSON.parse(
        File.read("spec/fixtures/dark_sky_responses/fetch_weather.rb")
      )
    end
    before(:each) do
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

        expect(ForecastItem.count).to eq 16
        ForecastItem.first.tap do |item|
          expect(item["precip_chance"]).to eq 15
          expect(item["temperature"]).to eq 60
          expect(item["unix_time"]).to eq "1525615200"
        end
        ForecastItem.last.tap do |item|
          expect(item["precip_chance"]).to eq 60
          expect(item["temperature"]).to eq 30
          expect(item["unix_time"]).to eq "1525777200"
        end
      end
    end

    context "when ForecastItems already exist" do
      context "when there is an error" do
        before do
          allow(ForecastItem).to receive(:create!).and_raise(ActiveRecord::RecordInvalid)
        end

        it "does not delete the existing record or save new ones" do
          forecast_item = create :forecast_item

          DarkSkyService.fetch_weather

          expect(ForecastItem.count).to eq 1
          expect { forecast_item.reload }.not_to raise_exception
        end
      end

      context "when there is no error" do
        it "deletes the existing items and creates new ones" do
          forecast_item = create :forecast_item

          DarkSkyService.fetch_weather

          expect(ForecastItem.count).to eq 16
          expect { forecast_item.reload }.to raise_exception ActiveRecord::RecordNotFound
          ForecastItem.first.tap do |item|
            expect(item["precip_chance"]).to eq 15
            expect(item["temperature"]).to eq 60
            expect(item["unix_time"]).to eq "1525615200"
          end
          ForecastItem.last.tap do |item|
            expect(item["precip_chance"]).to eq 60
            expect(item["temperature"]).to eq 30
            expect(item["unix_time"]).to eq "1525777200"
          end
        end
      end
    end
  end
end
