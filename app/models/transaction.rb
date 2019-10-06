class Transaction < ApplicationRecord
  validates_presence_of :invoice_id, :result, :credit_card_number
  validates :credit_card_expiration_date, presence: true, allow_blank: true

  belongs_to :invoice

  scope :successful, -> { where(result: "success") }
end
