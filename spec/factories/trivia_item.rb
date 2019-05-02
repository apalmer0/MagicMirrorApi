FactoryBot.define do
  factory :trivia_item do
    question { "question" }
    answer { "answer" }
    category { "foo" }
    value { 1000 }

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
