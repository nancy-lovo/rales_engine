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
end
