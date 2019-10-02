FactoryBot.define do
  factory :transaction do
    invoice_id { 1 }
    credit_card_number { 1 }
    credit_card_expiration_date { "" }
    result { "MyString" }
    created_at { "2010-11-02T14:37:48" }
    updated_at { "2010-11-02T14:37:48" }
    invoice
  end
end
