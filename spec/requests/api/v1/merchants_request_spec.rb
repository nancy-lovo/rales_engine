require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(3)
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"].to_i).to eq(id)
  end

  it "it can find first instance by id" do
    id = create(:merchant).id

    get "/api/v1/merchants/find?id=#{id}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["id"].to_i).to eq(id)
  end

  it "can find first instance by name" do
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["name"]).to eq(name)
  end

  it "can find first instance by created_at" do
    created_at = create(:merchant).created_at

    get "/api/v1/merchants/find?created_at=#{created_at}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful

    expected = Merchant.find(merchant["data"]["id"]).created_at
    expect(expected).to eq(created_at)
  end

  it "can find first instance by updated_at" do
    updated_at = create(:merchant).updated_at

    get "/api/v1/merchants/find?updated_at=#{updated_at}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful

    expected = Merchant.find(merchant["data"]["id"]).updated_at
    expect(expected).to eq(updated_at)
  end

  it "can find all instances by id" do
    id = create(:merchant).id

    get "/api/v1/merchants/find_all?id=#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful

    expect(merchant["data"].count).to eq(1)

    expected = merchant["data"].all? { |hash| hash["attributes"]["id"] == id }
    expect(expected).to eq(true)
  end

  it "can find all instances by name" do
    name = "Williamson Group"
    merchants = create_list(:merchant, 3)
    Merchant.update_all(name: name)
    klein = create(:merchant, name: "Klein")

    get "/api/v1/merchants/find_all?name=#{name}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful

    expect(merchant["data"].count).to eq(3)

    expected = merchant["data"].all? { |hash| hash["attributes"]["name"] == name }
    expect(expected).to eq(true)
  end

  it "can find all instances by created at" do
    merchants = create_list(:merchant, 3)
    created_at = merchants.first.created_at

    get "/api/v1/merchants/find_all?created_at=#{created_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful

    expect(merchant["data"].count).to eq(3)

    expected = merchant["data"].all? { |hash| Merchant.find(hash["id"]).created_at = created_at }
    expect(expected).to eq(true)
  end

  it "can find all instances by updated at" do
    merchants = create_list(:merchant, 3)
    updated_at = merchants.first.updated_at

    get "/api/v1/merchants/find_all?updated_at=#{updated_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful

    expect(merchant["data"].count).to eq(3)

    expected = merchant["data"].all? { |hash| Merchant.find(hash["id"]).updated_at = updated_at }
    expect(expected).to eq(true)
  end
end
