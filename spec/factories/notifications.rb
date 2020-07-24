FactoryBot.define do
  factory :notification do
    recipient_id { "" }
    actor_id { "" }
    read_at { "2020-07-24 12:41:48" }
    action { "MyString" }
    notifiable_id { "" }
    notifiable_type { "MyString" }
  end
end
