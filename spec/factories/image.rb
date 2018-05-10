FactoryBot.define do
  factory :image do
    sequence(:url) { |n| "https://example.com/images/#{n}.jpg" }
    from_number "15555555555"
    caption "this is a picture"
  end
end
