class Invoice < ApplicationRecord
  validates_presence_of :customer_id, :merchant_id, :status

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :merchant

  belongs_to :customer
  belongs_to :merchant
end
