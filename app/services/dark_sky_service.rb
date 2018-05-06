class DarkSkyService
  CAMBRIDGE_LATLNG = "42.3736,-71.1097"

  def self.fetch_weather
    new().fetch_weather
  end

  def fetch_weather
    hourly_weather.each do |hour|
      forecast_item = ForecastItem.find_by(unix_time: hour["time"])

      if forecast_item.present?
        forecast_item.update(
          precip_chance: hour["precipProbability"] * 100,
          temperature: hour["temperature"],
        )
      else
        ForecastItem.create!(
          unix_time: hour["time"],
          precip_chance: hour["precipProbability"] * 100,
          temperature: hour["temperature"],
        )
      end
    end
  end

  private

  def forecast
    @forecast ||= HTTParty.get(
      "https://api.darksky.net/forecast/#{ENV["DARK_SKY_KEY"]}/#{CAMBRIDGE_LATLNG}"
    )
  end

  def hourly_weather
    forecast.dig("hourly", "data")
  end
end
