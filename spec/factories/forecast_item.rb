FactoryBot.define do
  factory :forecast_item do
    PRECIP_CHANCE ||= [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
    TEMPERATURE ||= [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

    sequence(:unix_time) { |n| "%010d" % n }
    precip_chance PRECIP_CHANCE.sample
    temperature TEMPERATURE.sample
  end
end
