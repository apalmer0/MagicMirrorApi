class Image < ApplicationRecord
  validates :url, presence: true

  enum image_source: { twilio: 0, google: 1 }
  enum status: { active: 0, inactive: 1 }

  after_initialize :set_defaults

  private

  def set_defaults
    self.status ||= :active
  end
end
