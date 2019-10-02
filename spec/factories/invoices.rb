FactoryBot.define do
  factory :invoice do
    customer_id { 1 }
    merchant_id { 1 }
    status { "MyString" }
    created_at { "2010-11-02T14:37:48" }
    updated_at { "2010-11-02T14:37:48" }
    customer
    merchant
  end
end
