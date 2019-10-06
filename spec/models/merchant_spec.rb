require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "relationships" do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:invoices) }
  end

  describe "class methods" do
    it "#favorite_customer" do
      merchant = create(:merchant)
      customer_1 = create(:customer)
      invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant.id)
      transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
      transaction_2 = create(:transaction, invoice_id: invoice_1.id, result: "success")

      customer_2 = create(:customer)
      invoice_2 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant.id)
      transaction_3 = create(:transaction, invoice_id: invoice_2.id, result: "success")
      transaction_4 = create(:transaction, invoice_id: invoice_2.id, result: "failed")

      customer_3 = create(:customer)
      invoice_3 = create(:invoice, customer_id: customer_3.id, merchant_id: merchant.id)
      transaction_5 = create(:transaction, invoice_id: invoice_3.id, result: "failed")

      expect(Merchant.favorite_customer(merchant.id)).to eq(customer_1)
    end

    it "#most_revenue" do
      merchant_1 = create(:merchant, name: "merchant 1")
      item_1 = create(:item, merchant_id: merchant_1.id, unit_price: 10)
      invoice_1 = create(:invoice, merchant_id: merchant_1.id)
      invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, quantity: 5)

      merchant_2 = create(:merchant, name: "merchant 2")
      item_2 = create(:item, merchant_id: merchant_2.id, unit_price: 5)
      invoice_2 = create(:invoice, merchant_id: merchant_2.id)
      invoice_item_2 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_2.id, quantity: 5)

      merchant_3 = create(:merchant, name: "merchant 3")
      item_3 = create(:item, merchant_id: merchant_3.id, unit_price: 1)
      invoice_3 = create(:invoice, merchant_id: merchant_3.id)
      invoice_item_3 = create(:invoice_item, invoice_id: invoice_3.id, item_id: item_3.id, quantity: 5)

      quantity = 2

      expect(Merchant.most_revenue(quantity).size).to eq(2)
      expect(Merchant.most_revenue(quantity)[0]).to eq(merchant_1)
      expect(Merchant.most_revenue(quantity)[1]).to eq(merchant_2)
    end
  end
end
