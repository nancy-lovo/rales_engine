require 'rails_helper'

describe "Invoices API" do
  it "sends a list of invoices" do
    create_list(:invoice, 3)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)
    expect(invoices["data"].count).to eq(3)
  end

  it "can get one invoice by its id" do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["id"].to_i).to eq(id)
  end

  it "it can find first instance by id" do
    id = create(:invoice).id

    get "/api/v1/invoices/find?id=#{id}"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice["data"]["attributes"]["id"].to_i).to eq(id)
  end

  it "can find first instance by customer id" do
    customer_id = create(:invoice).customer_id

    get "/api/v1/invoices/find?customer_id=#{customer_id}"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice["data"]["attributes"]["customer_id"]).to eq(customer_id)
  end

  it "can find first instance by merchant id" do
    merchant_id = create(:invoice).merchant_id

    get "/api/v1/invoices/find?merchant_id=#{merchant_id}"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice["data"]["attributes"]["merchant_id"]).to eq(merchant_id)
  end

  it "can find first instance by status" do
    status = create(:invoice).status

    get "/api/v1/invoices/find?status=#{status}"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice["data"]["attributes"]["status"]).to eq(status)
  end

  it "can find first instance by created_at" do
    created_at = create(:invoice).created_at

    get "/api/v1/invoices/find?created_at=#{created_at}"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful

    expected = Invoice.find(invoice["data"]["id"]).created_at
    expect(expected).to eq(created_at)
  end

  it "can find first instance by updated_at" do
    updated_at = create(:invoice).updated_at

    get "/api/v1/invoices/find?updated_at=#{updated_at}"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful

    expected = Invoice.find(invoice["data"]["id"]).updated_at
    expect(expected).to eq(updated_at)
  end

  it "can find all instances by id" do
    id = create(:invoice).id

    get "/api/v1/invoices/find_all?id=#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoice["data"].count).to eq(1)

    expected = invoice["data"].all? { |hash| hash["attributes"]["id"] == id }
    expect(expected).to eq(true)
  end

  it "can find all instances by customer id" do
    customer_id = 1
    invoices = create_list(:invoice, 3)
    Invoice.update_all(customer_id: customer_id)

    get "/api/v1/invoices/find_all?customer_id=#{customer_id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoice["data"].count).to eq(3)

    expected = invoice["data"].all? { |hash| hash["attributes"]["customer_id"] == customer_id }
    expect(expected).to eq(true)
  end

  it "can find all instances by merchant id" do
    merchant_id = 1
    invoices = create_list(:invoice, 3)
    Invoice.update_all(merchant_id: merchant_id)

    get "/api/v1/invoices/find_all?merchant_id=#{merchant_id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoice["data"].count).to eq(3)

    expected = invoice["data"].all? { |hash| hash["attributes"]["merchant_id"] == merchant_id }
    expect(expected).to eq(true)
  end

  it "can find all instances by status" do
    status = "shipped"
    invoices = create_list(:invoice, 3)
    Invoice.update_all(status: status)
    pending = create(:invoice, status: 'pending')

    get "/api/v1/invoices/find_all?status=#{status}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoice["data"].count).to eq(3)

    expected = invoice["data"].all? { |hash| hash["attributes"]["status"] == status }
    expect(expected).to eq(true)
  end

  it "can find all instances by created at" do
    invoices = create_list(:invoice, 3)
    created_at = invoices.first.created_at

    get "/api/v1/invoices/find_all?created_at=#{created_at}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoice["data"].count).to eq(3)

    expected = invoice["data"].all? { |hash| Invoice.find(hash["id"]).created_at = created_at }
    expect(expected).to eq(true)
  end

  it "can find all instances by updated at" do
    invoices = create_list(:invoice, 3)
    updated_at = invoices.first.updated_at

    get "/api/v1/invoices/find_all?updated_at=#{updated_at}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoice["data"].count).to eq(3)

    expected = invoice["data"].all? { |hash| Invoice.find(hash["id"]).updated_at = updated_at }
    expect(expected).to eq(true)
  end

  it "can return a random resource" do
    invoices = create_list(:invoice, 5)

    get "/api/v1/invoices/random"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoice["data"].count).to eq(1)
    expect(invoice["data"].first["type"]).to eq("invoice")
    expect(invoice["data"].first["attributes"].keys).to eq(["id", "customer_id", "merchant_id", "status"])
  end

  it "can return a collection of associated transactions" do
    invoice_1 = create(:invoice)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_1.id)

    get "/api/v1/invoices/#{invoice_1.id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful

    expected = transactions["data"].all? { |hash| hash["type"] == 'transaction' }

    expect(expected).to eq(true)
    expect(transactions["data"].size).to eq(2)

    expect(transactions["data"].first["attributes"]["invoice_id"]).to eq(invoice_1.id)
    expect(transactions["data"].second["attributes"]["invoice_id"]).to eq(invoice_1.id)
  end

  it "can return a collection of associated invoice items" do
    invoice = create(:invoice)
    invoice_item_1 = create(:invoice_item, invoice_id: invoice.id)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice.id)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful

    expected_type = invoice_items["data"].all? { |hash| hash["type"] == 'invoice_item' }
    expected_invoice_id = invoice_items["data"].all? { |hash| hash["attributes"]["invoice_id"] == invoice.id }

    expect(invoice_items["data"].size).to eq(2)
    expect(expected_type).to eq(true)
    expect(expected_invoice_id).to eq(true)
  end

  it "can return a collection of associated items" do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id)
    item_1 = create(:item, merchant_id: merchant.id)
    item_2 = create(:item, merchant_id: merchant.id)

    get "/api/v1/invoices/#{invoice.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful

    expect(items["data"].size).to eq(2)

    expected_type = items["data"].all? { |item| item["type"] == 'item' }
    expect(expected_type).to eq(true)

    item_1_merchant_id = items["data"].first["attributes"]["merchant_id"]
    item_2_merchant_id = items["data"].second["attributes"]["merchant_id"]

    expect(item_1_merchant_id).to eq(merchant.id)
    expect(item_2_merchant_id).to eq(merchant.id)
  end

  it "can return the associated customer" do
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id)

    get "/api/v1/invoices/#{invoice.id}/customer"

    invoice_customer = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoice_customer["data"]["type"]).to eq('customer')
    expect(invoice_customer["data"]["attributes"]["id"]).to eq(customer.id)
  end

  it "can return the associated merchant" do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    invoice_merchant = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoice_merchant["data"]["type"]).to eq('merchant')
    expect(invoice_merchant["data"]["attributes"]["id"]).to eq(merchant.id)
  end

end
