class TriviaItem < ApplicationRecord
  after_initialize :set_defaults

  validates :question, presence: true
  validates :answer, presence: true
  validates :category, presence: true
  validates :value, presence: true

  enum status: { unanswered: 0, incorrect: 1, correct: 2 }

  private

  def set_defaults
    self.status ||= :unanswered
  end
end
