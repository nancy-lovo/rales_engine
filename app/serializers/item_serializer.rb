class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :unit_price, :merchant_id

  attribute :unit_price do |object|
    up = object['unit_price']
    if up > 100
      (up / 100.to_f).to_s
    else
      '%.2f' % up
    end
  end
end
