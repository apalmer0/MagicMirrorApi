class Image < ApplicationRecord
  validates :url, presence: true

  enum image_source: {
    twilio: 0,
    google: 1,
  }
end
