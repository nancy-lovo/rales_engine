class Transaction < ApplicationRecord
  validates_presence_of :invoice_id, :result
  validates_numericality_of :credit_card_number, greater_than: 0, only_integer: true
  validates :credit_card_expiration_date, presence: true, allow_blank: true

  belongs_to :invoice
end
