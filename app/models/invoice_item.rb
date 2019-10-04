class InvoiceItem < ApplicationRecord
  validates_presence_of :item_id, :invoice_id
  validates_numericality_of :unit_price, greater_than_or_equal_to: 0, only_integer: true
  validates_numericality_of :quantity, greater_than_or_equal_to: 0, only_integer: true
  belongs_to :invoice
  belongs_to :item
end
