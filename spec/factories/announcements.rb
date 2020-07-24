FactoryBot.define do
  factory :announcement do
    published_at { "2020-07-24 12:41:43" }
    announcement_type { "MyString" }
    name { "MyString" }
    description { "MyText" }
  end
end
