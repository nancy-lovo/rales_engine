FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyString" }
    unit_price { 75107 }
    merchant_id { 1 }
    created_at { "2010-11-02T14:37:48" }
    updated_at { "2010-11-02T14:37:48" }
    merchant
  end
end
