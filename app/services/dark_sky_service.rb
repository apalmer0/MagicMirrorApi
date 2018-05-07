class DarkSkyService
  CAMBRIDGE_LATLNG = "42.3736,-71.1097"

  def self.fetch_weather
    new().fetch_weather
  end

  def fetch_weather
    ActiveRecord::Base.transaction do
      ForecastItem.delete_all
      save_weather
    end

  rescue ActiveRecord::RecordInvalid
    puts "You tried saving an invalid ForecastItem" if Rails.env != "test"
  end

  private

  def save_weather
    hourly_weather.each_slice(3) do |subarray_of_three_hours|
      create_three_hour_block(subarray_of_three_hours)
    end
  end

  def create_three_hour_block(items)
    total_chance = items.reduce(0) { |memo, obj| memo + (obj["precipProbability"] * 100) }
    total_temp = items.reduce(0) { |memo, obj| memo + (obj["temperature"]) }

    ForecastItem.create!(
      precip_chance: (total_chance / 3),
      temperature: (total_temp / 3),
      unix_time: items[0]["time"],
    )
  end

  def forecast
    @forecast ||= HTTParty.get(
      "https://api.darksky.net/forecast/#{ENV["DARK_SKY_KEY"]}/#{CAMBRIDGE_LATLNG}"
    )
  end

  def hourly_weather
    all_hours = forecast.dig("hourly", "data")
    all_hours.shift
    all_hours
  end
end