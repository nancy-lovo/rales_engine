class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices

  def self.favorite_customer(merchant_id)
    Customer.select("customers.*, count(transactions.result) as count")
      .joins(:invoices, :transactions)
      .merge(Transaction.successful)
      .group(:id)
      .order("count DESC")
      .first
  end

  def self.most_revenue(quantity)
    joins(items: [:invoice_items])
      .select("merchants.*, SUM(items.unit_price * invoice_items.quantity) AS revenue")
      .group(:id)
      .order('revenue DESC')
      .limit(quantity)
  end

  def self.total_revenue_by_date(date)
    joins(items: [:invoice_items])
    .where("invoice_items.created_at = '#{date}'")
    .sum('items.unit_price * invoice_items.quantity')
  end
end
