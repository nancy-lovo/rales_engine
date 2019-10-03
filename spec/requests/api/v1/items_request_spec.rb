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
    name_ci = name.downcase

    get "/api/v1/items/find?name=#{name}"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["data"]["attributes"]["name"]).to eq(name)

    get "/api/v1/items/find?name=#{name_ci}"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["data"]["attributes"]["name"]).to eq(name)
  end

  it "can find first instance by description" do
    description = create(:item).description
    description_ci = description.downcase

    get "/api/v1/items/find?description=#{description}"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["data"]["attributes"]["description"]).to eq(description)

    get "/api/v1/items/find?description=#{description_ci}"

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

    expected = Item.find(item["data"]["id"]).created_at
    expect(expected).to eq(created_at)
  end

  it "can find first instance by updated_at" do
    updated_at = create(:item).updated_at

    get "/api/v1/items/find?updated_at=#{updated_at}"

    item = JSON.parse(response.body)
    expect(response).to be_successful

    expected = Item.find(item["data"]["id"]).updated_at
    expect(expected).to eq(updated_at)
  end

  it "can find all instances by id" do
    id = create(:item).id

    get "/api/v1/items/find_all?id=#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful

    expect(item["data"].count).to eq(1)

    expected = item["data"].all? { |hash| hash["attributes"]["id"] == id }
    expect(expected).to eq(true)
  end

  it "can find all instances by name" do
    name = "cookie"
    items = create_list(:item, 3)
    Item.update_all(name: name)
    fruit = create(:item, name: "fruit")

    get "/api/v1/items/find_all?name=#{name}"

    item = JSON.parse(response.body)

    expect(response).to be_successful

    expect(item["data"].count).to eq(3)

    expected = item["data"].all? { |hash| hash["attributes"]["name"] == name }
    expect(expected).to eq(true)

    get "/api/v1/items/find_all?name=#{name.upcase}"

    item = JSON.parse(response.body)

    expect(response).to be_successful

    expect(item["data"].count).to eq(3)

    expected = item["data"].all? { |hash| hash["attributes"]["name"] == name }
    expect(expected).to eq(true)
  end

  it "can find all instances by description" do
    description = "very sweet"
    items = create_list(:item, 3)
    Item.update_all(description: description)
    bad_item = create(:item, description: "very bad")

    get "/api/v1/items/find_all?description=#{description}"

    item = JSON.parse(response.body)

    expect(response).to be_successful

    expect(item["data"].count).to eq(3)

    expected = item["data"].all? { |hash| hash["attributes"]["description"] == description }
    expect(expected).to eq(true)

    get "/api/v1/items/find_all?description=#{description.upcase}"

    item = JSON.parse(response.body)

    expect(response).to be_successful

    expect(item["data"].count).to eq(3)

    expected = item["data"].all? { |hash| hash["attributes"]["description"] == description }
    expect(expected).to eq(true)
  end

  it "can find all instances by unit_price" do
    unit_price = "10.00"
    items = create_list(:item, 3)
    Item.update_all(unit_price: unit_price)
    item_2 = create(:item, unit_price: '15.00')

    get "/api/v1/items/find_all?unit_price=#{unit_price}"

    item = JSON.parse(response.body)

    expect(response).to be_successful

    expect(item["data"].count).to eq(3)

    expected = item["data"].all? { |hash| hash["attributes"]["unit_price"] == unit_price }
    expect(expected).to eq(true)
  end

  it "can find all instances by merchant id" do
    merchant_id = 1
    items = create_list(:item, 3)
    Item.update_all(merchant_id: merchant_id)

    get "/api/v1/items/find_all?merchant_id=#{merchant_id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful

    expect(item["data"].count).to eq(3)

    expected = item["data"].all? { |hash| hash["attributes"]["merchant_id"] == merchant_id }
    expect(expected).to eq(true)
  end

  it "can find all instances by created at" do
    items = create_list(:item, 3)
    created_at = items.first.created_at

    get "/api/v1/items/find_all?created_at=#{created_at}"

    item = JSON.parse(response.body)

    expect(response).to be_successful

    expect(item["data"].count).to eq(3)

    expected = item["data"].all? { |hash| Item.find(hash["id"]).created_at = created_at }
    expect(expected).to eq(true)
  end

  it "can find all instances by updated at" do
    items = create_list(:item, 3)
    updated_at = items.first.updated_at

    get "/api/v1/items/find_all?updated_at=#{updated_at}"

    item = JSON.parse(response.body)

    expect(response).to be_successful

    expect(item["data"].count).to eq(3)

    expected = item["data"].all? { |hash| Item.find(hash["id"]).updated_at = updated_at }
    expect(expected).to eq(true)
  end
end
