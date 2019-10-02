FactoryBot.define do
  factory :customer do
    first_name { "MyString" }
    last_name { "MyString" }
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
    updated_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
  end
end
