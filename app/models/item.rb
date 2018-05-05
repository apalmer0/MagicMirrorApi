class Item < ApplicationRecord
  after_initialize :set_defaults

  enum status: { incomplete: 0, complete: 1 }

  def self.due_today
    where("due <= ?", Date.today)
  end

  def self.for_user(user_id)
    where(user_id: user_id)
  end

  private

  def set_defaults
    self.status ||= :incomplete
    self.due ||= Date.today
  end
end
