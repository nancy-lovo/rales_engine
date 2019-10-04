FactoryBot.define do
  factory :invoice_item do
    item_id { 1 }
    invoice_id { 1 }
    quantity { 1 }
    unit_price { 75107 }
    created_at { "2010-11-02T14:37:48" }
    updated_at { "2010-11-02T14:37:48" }
    item
    invoice
  end
end
