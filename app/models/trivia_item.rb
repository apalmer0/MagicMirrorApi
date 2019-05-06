class TriviaItem < ApplicationRecord
  after_initialize :set_defaults

  validates :category, presence: true
  validates :correct_answer, presence: true
  validates :difficulty, presence: true
  validates :incorrect_answers, presence: true
  validates :question_type, presence: true
  validates :question, presence: true

  enum status: { unanswered: 0, incorrect: 1, correct: 2 }

  private

  def set_defaults
    self.status ||= :unanswered
  end
end
