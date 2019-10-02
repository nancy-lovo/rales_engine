require 'rails_helper'

describe "Invoice Items API" do
  it "sends a list of invoice items" do
    invoice_item_1 = create(:invoice_item, item_id: create(:item).id, invoice_id: create(:invoice).id)
    invoice_item_2 = create(:invoice_item, item_id: create(:item).id, invoice_id: create(:invoice).id)
    invoice_item_3 = create(:invoice_item, item_id: create(:item).id, invoice_id: create(:invoice).id)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)
    expect(invoice_items["data"].count).to eq(3)
  end

  it "can get one invoice_item by its id" do
    id = create(:invoice_item, item_id: create(:item).id, invoice_id: create(:invoice).id).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["id"].to_i).to eq(id)
  end
end
