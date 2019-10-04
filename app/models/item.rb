class Item < ApplicationRecord
  validates_presence_of :name, :description, :merchant_id
  validates_numericality_of :unit_price, greater_than_or_equal_to: 0, only_integer: true

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  belongs_to :merchant

  def self.order_items
    order(:id)
  end
end
