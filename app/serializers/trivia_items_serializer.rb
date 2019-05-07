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
             :status

  def options
    object.letters_and_answers
  end
end
