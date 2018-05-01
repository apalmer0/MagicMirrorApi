class Item < ApplicationRecord
  after_initialize :set_defaults

  enum status: { incomplete: 0, complete: 1 }

  private

  def set_defaults
    self.status ||= :incomplete
    self.due ||= DateTime.now.end_of_day.utc
  end
end
