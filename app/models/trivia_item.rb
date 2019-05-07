class TriviaItem < ApplicationRecord
  include ActiveModel::Serialization

  A = "A".freeze
  B = "B".freeze
  C = "C".freeze
  D = "D".freeze
  CHOICES = [A, B, C, D].freeze
  MULTIPLE = "multiple".freeze

  after_initialize :set_defaults

  validates :category, presence: true
  validates :correct_answer, presence: true
  validates :difficulty, presence: true
  validates :incorrect_answers, presence: true
  validates :question_type, presence: true
  validates :question, presence: true

  enum status: { unanswered: 0, incorrect: 1, correct: 2 }

  def letters_and_answers
    return {} unless multiple_choice?

    answers_hash = {}
    answers_hash[correct_letter] = correct_answer
    remaining_choices = CHOICES - [correct_letter]

    remaining_choices.each_with_index do |letter, index|
      answers_hash[letter] = incorrect_answers[index]
    end

    answers_hash.sort_by { |key| key }.to_h
  end

  def multiple_choice?
    question_type == MULTIPLE
  end

  def correct_response
    multiple_choice? ? correct_letter : correct_answer
  end

  def assigned_correct_letter
    if question_type == MULTIPLE
      CHOICES.sample
    else
      nil
    end
  end

  private

  def set_defaults
    self.status ||= :unanswered
    self.correct_letter ||= assigned_correct_letter
  end
end
