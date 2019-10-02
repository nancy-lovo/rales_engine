FactoryBot.define do
  factory :transaction do
    invoice_id { 1 }
    credit_card_number { 1 }
    credit_card_expiration_date { "" }
    result { "MyString" }
  end
end
