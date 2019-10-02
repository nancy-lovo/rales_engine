require 'rails_helper'

describe "Invoice Items API" do
  it "sends a list of invoice items" do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)
    expect(invoice_items["data"].count).to eq(3)
  end

  it "can get one invoice_item by its id" do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["id"].to_i).to eq(id)
  end

  it "it can find first instance by id" do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/find?id=#{id}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"]["attributes"]["id"].to_i).to eq(id)
  end

  it "can find first instance by item id" do
    item_id = create(:invoice_item).item_id

    get "/api/v1/invoice_items/find?item_id=#{item_id}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"]["attributes"]["item_id"]).to eq(item_id)
  end

  it "can find first instance by invoice id" do
    invoice_id = create(:invoice_item).invoice_id

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_id}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(invoice_id)
  end

  it "can find first instance by unit price" do
    unit_price = create(:invoice_item).unit_price

    get "/api/v1/invoice_items/find?unit_price=#{unit_price}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"]["attributes"]["unit_price"]).to eq(unit_price)
  end

  it "can find first instance by quantity" do
    quantity = create(:invoice_item).quantity

    get "/api/v1/invoice_items/find?quantity=#{quantity}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"]["attributes"]["quantity"]).to eq(quantity)
  end

  it "can find first instance by created_at" do
    created_at = create(:invoice_item).created_at

    get "/api/v1/invoice_items/find?created_at=#{created_at}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful

    expect(invoice_item["data"]["attributes"]["created_at"]).to eq(created_at.strftime('%Y-%m-%dT%H:%M:%S.000Z'))
  end

  it "can find first instance by updated_at" do
    updated_at = create(:invoice_item).updated_at

    get "/api/v1/invoice_items/find?updated_at=#{updated_at}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful

    expect(invoice_item["data"]["attributes"]["updated_at"]).to eq(updated_at.strftime('%Y-%m-%dT%H:%M:%S.000Z'))
  end
end
