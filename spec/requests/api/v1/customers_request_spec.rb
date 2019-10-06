require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)
    expect(customers["data"].count).to eq(3)
  end

  it "can get one customer by its id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"].to_i).to eq(id)
  end

  it "it can find first instance by id" do
    id = create(:customer).id

    get "/api/v1/customers/find?id=#{id}"

    customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer["data"]["attributes"]["id"].to_i).to eq(id)
  end

  it "can find first instance by first name, case-insensitive" do
    first_name = create(:customer).first_name
    first_name_ci = first_name.downcase

    get "/api/v1/customers/find?first_name=#{first_name}"

    customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer["data"]["attributes"]["first_name"]).to eq(first_name)

    get "/api/v1/customers/find?first_name=#{first_name_ci}"

    customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer["data"]["attributes"]["first_name"]).to eq(first_name)
  end

  it "can find first instance by last name" do
    last_name = create(:customer).last_name
    last_name_ci = last_name.downcase

    get "/api/v1/customers/find?last_name=#{last_name}"

    customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer["data"]["attributes"]["last_name"]).to eq(last_name)

    get "/api/v1/customers/find?last_name=#{last_name_ci}"

    customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer["data"]["attributes"]["last_name"]).to eq(last_name)
  end

  it "can find first instance by created_at" do
    created_at = create(:customer).created_at

    get "/api/v1/customers/find?created_at=#{created_at}"

    customer = JSON.parse(response.body)
    expect(response).to be_successful

    expected = Customer.find(customer["data"]["id"]).created_at
    expect(expected).to eq(created_at)
  end

  it "can find first instance by updated_at" do
    updated_at = create(:customer).updated_at

    get "/api/v1/customers/find?updated_at=#{updated_at}"

    customer = JSON.parse(response.body)
    expect(response).to be_successful

    expected = Customer.find(customer["data"]["id"]).updated_at
    expect(expected).to eq(updated_at)
  end

  it "can find all instances by id" do
    id = create(:customer).id

    get "/api/v1/customers/find_all?id=#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful

    expect(customer["data"].count).to eq(1)

    expected = customer["data"].all? { |hash| hash["attributes"]["id"] == id }
    expect(expected).to eq(true)
  end

  it "can find all instances by first name" do
    customer_1 = create(:customer, first_name: "Sam")
    customer_2 = create(:customer, first_name: "Sam")
    customer_3 = create(:customer, first_name: "Sam")

    get "/api/v1/customers/find_all?first_name=Sam"

    customer = JSON.parse(response.body)

    expect(response).to be_successful

    expect(customer["data"].count).to eq(3)

    expected = customer["data"].all? { |hash| hash["attributes"]["first_name"] == "Sam" }
    expect(expected).to eq(true)

    get "/api/v1/customers/find_all?first_name=sam"

    customer = JSON.parse(response.body)

    expect(response).to be_successful

    expect(customer["data"].count).to eq(3)

    expected = customer["data"].all? { |hash| hash["attributes"]["first_name"] == "Sam" }
    expect(expected).to eq(true)
  end

  it "can find all instances by last name" do
    customer_1 = create(:customer, last_name: "Sam")
    customer_2 = create(:customer, last_name: "Sam")
    customer_3 = create(:customer, last_name: "Sam")

    get "/api/v1/customers/find_all?last_name=Sam"

    customer = JSON.parse(response.body)

    expect(response).to be_successful

    expect(customer["data"].count).to eq(3)

    expected = customer["data"].all? { |hash| hash["attributes"]["last_name"] == "Sam" }
    expect(expected).to eq(true)

    get "/api/v1/customers/find_all?last_name=sam"

    customer = JSON.parse(response.body)

    expect(response).to be_successful

    expect(customer["data"].count).to eq(3)

    expected = customer["data"].all? { |hash| hash["attributes"]["last_name"] == "Sam" }
    expect(expected).to eq(true)
  end

  it "can find all instances by created at" do
    customers = create_list(:customer, 3)
    created_at = customers.first.created_at

    get "/api/v1/customers/find_all?created_at=#{created_at}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful

    expect(customer["data"].count).to eq(3)

    expected = customer["data"].all? { |hash| Customer.find(hash["id"]).created_at = created_at }
    expect(expected).to eq(true)
  end

  it "can find all instances by updated at" do
    customers = create_list(:customer, 3)
    updated_at = customers.first.updated_at

    get "/api/v1/customers/find_all?updated_at=#{updated_at}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful

    expect(customer["data"].count).to eq(3)

    expected = customer["data"].all? { |hash| Customer.find(hash["id"]).updated_at = updated_at }
    expect(expected).to eq(true)
  end

  it "can return a random resource" do
    customers = create_list(:customer, 5)

    get "/api/v1/customers/random"

    customer = JSON.parse(response.body)

    expect(response).to be_successful

    expect(customer["data"].count).to eq(1)
    expect(customer["data"].first["type"]).to eq("customer")
    expect(customer["data"].first["attributes"].keys).to eq(["id", "first_name", "last_name"])
  end

  it "can return a collection of associated invoices" do
    customer_1 = create(:customer)
    invoice_1 = create(:invoice, customer_id: customer_1.id)
    invoice_2 = create(:invoice, customer_id: customer_1.id)

    get "/api/v1/customers/#{customer_1.id}/invoices"

    customer = JSON.parse(response.body)

    expect(response).to be_successful

    expected = customer["data"].all? { |hash| hash["type"] == 'invoices' }
    expected = customer["data"].all? { |hash| hash["attributes"]["customer_id"] == customer_1.id }

    expect(customer["data"].size).to eq(2)
    expect(expected).to eq(true)
  end

  it "can return a collection of associated transactions" do
    customer_1 = create(:customer)
    invoice_1 = create(:invoice, customer_id: customer_1.id)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_1.id)

    invoice_2 = create(:invoice, customer_id: customer_1.id)
    transaction_3 = create(:transaction, invoice_id: invoice_2.id)

    get "/api/v1/customers/#{customer_1.id}/transactions"

    customer = JSON.parse(response.body)

    expect(response).to be_successful

    expected = customer["data"].all? { |hash| hash["type"] == 'transaction' }

    expect(expected).to eq(true)
    expect(customer["data"].size).to eq(3)

    expect(customer["data"].first["attributes"]["invoice_id"]).to eq(invoice_1.id)
    expect(customer["data"].second["attributes"]["invoice_id"]).to eq(invoice_1.id)
    expect(customer["data"].last["attributes"]["invoice_id"]).to eq(invoice_2.id)
  end
end
