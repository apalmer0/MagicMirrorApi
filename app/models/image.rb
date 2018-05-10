class Image < ApplicationRecord
  validates :url, presence: true
  validates :from_number, presence: true
end
