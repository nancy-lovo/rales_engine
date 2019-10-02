class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at
end
