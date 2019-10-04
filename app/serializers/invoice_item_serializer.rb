class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :item_id, :invoice_id, :quantity, :unit_price

  attribute :unit_price do |object|
    up = object['unit_price']
    if up > 100
      (up / 100.to_f).to_s
    else
      '%.2f' % up
    end
  end
end
