FactoryBot.define do
  factory :trivia_item do
    question { "question" }
    correct_answer { "answer" }
    incorrect_answers do
      ["wrong answer", "another wrong answer", "third wrong answer"]
    end
    category { "foo" }
    difficulty { "hard" }
    question_type { "multiple" }

    trait :unanswered do
      status { :unanswered }
    end

    trait :incorrect do
      status { :incorrect }
    end

    trait :correct do
      status { :correct }
    end
  end
end
