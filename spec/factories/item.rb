FactoryBot.define do
  factory :item do
    TODAY ||= Date.current
    CONTENT_OPTIONS ||=
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
        "reinvent the wheel",
        "assemble popsicle stick bridge"
      ]

    sequence(:todoist_id) { |n| "%010d" % n }
    sequence(:user_id) { |n| "%07d" % n }
    content CONTENT_OPTIONS.sample

    trait :incomplete do
      status :incomplete
    end

    trait :complete do
      status :complete
    end

    trait :today do
      due TODAY
    end

    trait :tomorrow do
      due TODAY + 1.day
    end

    trait :yesterday do
      due TODAY - 1.day
    end
  end
end
