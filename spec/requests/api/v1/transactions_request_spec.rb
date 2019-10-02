require 'rails_helper'

describe "Transactions API" do
  it "sends a list of transactions" do
    transaction_1 = create(:transaction, invoice_id: create(:invoice).id)
    transaction_2 = create(:transaction, invoice_id: create(:invoice).id)
    transaction_3 = create(:transaction, invoice_id: create(:invoice).id)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)
    expect(transactions["data"].count).to eq(3)
  end

  it "can get one transaction by its id" do
    id = create(:transaction, invoice_id: create(:invoice).id).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["id"].to_i).to eq(id)
  end
end
