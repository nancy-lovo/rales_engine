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
    expect(customer["data"]["id"].to_i).to eq(id)
  end

  it "can find first instance by first name" do
    first_name = create(:customer).first_name

    get "/api/v1/customers/find?first_name=#{first_name}"

    customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer["data"]["attributes"]["first_name"]).to eq(first_name)
  end

  it "can find first instance by last name" do
    last_name = create(:customer).last_name

    get "/api/v1/customers/find?last_name=#{last_name}"

    customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer["data"]["attributes"]["last_name"]).to eq(last_name)
  end

  it "can find first instance by created_at" do
    created_at = create(:customer).created_at

    get "/api/v1/customers/find?created_at=#{created_at}"

    customer = JSON.parse(response.body)
    expect(response).to be_successful

    expect(customer["data"]["attributes"]["created_at"]).to eq(created_at)
  end
end
