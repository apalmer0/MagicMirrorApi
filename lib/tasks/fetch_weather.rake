desc "Fetch weather forecast from DarkSky"
task fetch_weather: :environment do
  DarkSkyService.fetch_weather
end
