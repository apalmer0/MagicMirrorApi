FactoryBot.define do
  factory :item do
    TODAY = "today"
    TOMORROW = "tomorrow"
    YESTERDAY = "yesterday"
    CONTENT_OPTIONS =
      [
        "walk the dog",
        "teach angela merkel how to solve a rubik's cube",
        "join the nba",
        "visit mars",
        "pay taxes",
        "feed the hog",
        "save the world",
        "paint a masterpiece",
        "become a pirate",
        "ask elon musk what he eats for breakfast",
      ]

    transient { due_day TODAY }

    sequence(:todoist_id) { |n| "%010d" % n }
    sequence(:user_id) { |n| "%07d" % n }
    sequence(:content) { |n| CONTENT_OPTIONS[n] }

    trait :today do
      status :active
    end

    trait :incomplete do
      status :incomplete
    end

    trait :complete do
      status :complete
    end

    before(:create) do |item, evaluator|
      case evaluator.due_day
      when TODAY
        item.due = DateTime.now
      when TOMORROW
        item.due = DateTime.now + 1.day
      when YESTERDAY
        item.due = DateTime.now - 1.day
      end
    end
  end
end
