class ForecastItem < ApplicationRecord
  validates :unix_time, presence: true, uniqueness: { case_sensitive: false }
  validates :precip_chance, presence: true
  validates :temperature, presence: true
end
