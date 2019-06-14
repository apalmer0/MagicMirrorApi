class TriviaItemsSerializer < ActiveModel::Serializer
  attributes :category,
             :correct_answer,
             :correct_letter,
             :difficulty,
             :guess,
             :incorrect_answers,
             :options,
             :question_type,
             :question,
             :status,
             :streak_count

  def options
    object.letters_and_answers
  end

  def streak_count
    object.streak_count
  end
end
