require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(3)
  end

  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"].to_i).to eq(id)
  end

  it "it can find first instance by id" do
    id = create(:item).id

    get "/api/v1/items/find?id=#{id}"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["data"]["attributes"]["id"].to_i).to eq(id)
  end

  it "can find first instance by name" do
    name = create(:item).name

    get "/api/v1/items/find?name=#{name}"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["data"]["attributes"]["name"]).to eq(name)
  end

  it "can find first instance by description" do
    description = create(:item).description

    get "/api/v1/items/find?description=#{description}"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["data"]["attributes"]["description"]).to eq(description)
  end

  it "can find first instance by unit_price" do
    unit_price = create(:item).unit_price

    get "/api/v1/items/find?unit_price=#{unit_price}"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["data"]["attributes"]["unit_price"]).to eq(unit_price)
  end

  it "can find first instance by merchant id" do
    merchant_id = create(:item).merchant_id

    get "/api/v1/items/find?merchant_id=#{merchant_id}"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["data"]["attributes"]["merchant_id"]).to eq(merchant_id)
  end

  it "can find first instance by created_at" do
    created_at = create(:item).created_at

    get "/api/v1/items/find?created_at=#{created_at}"

    item = JSON.parse(response.body)
    expect(response).to be_successful

    expect(item["data"]["attributes"]["created_at"]).to eq(created_at.strftime('%Y-%m-%dT%H:%M:%S.000Z'))
  end

  it "can find first instance by updated_at" do
    updated_at = create(:item).updated_at

    get "/api/v1/items/find?updated_at=#{updated_at}"

    item = JSON.parse(response.body)
    expect(response).to be_successful

    expect(item["data"]["attributes"]["updated_at"]).to eq(updated_at.strftime('%Y-%m-%dT%H:%M:%S.000Z'))
  end
end
