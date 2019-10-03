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

  it "it can find first instance by id" do
    id = create(:transaction).id

    get "/api/v1/transactions/find?id=#{id}"

    transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction["data"]["attributes"]["id"].to_i).to eq(id)
  end

  it "can find first instance by invoice id" do
    invoice_id = create(:transaction).invoice_id

    get "/api/v1/transactions/find?invoice_id=#{invoice_id}"

    transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction["data"]["attributes"]["invoice_id"]).to eq(invoice_id)
  end

  it "can find first instance by credit_card_number" do
    credit_card_number = create(:transaction).credit_card_number

    get "/api/v1/transactions/find?credit_card_number=#{credit_card_number}"

    transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction["data"]["attributes"]["credit_card_number"]).to eq(credit_card_number)
  end

  it "can find first instance by result" do
    result = create(:transaction).result

    get "/api/v1/transactions/find?result=#{result}"

    transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction["data"]["attributes"]["result"]).to eq(result)
  end

  it "can find first instance by created_at" do
    created_at = create(:transaction).created_at

    get "/api/v1/transactions/find?created_at=#{created_at}"

    transaction = JSON.parse(response.body)
    expect(response).to be_successful

    expected = Transaction.find(transaction["data"]["id"]).created_at
    expect(expected).to eq(created_at)
  end

  it "can find first instance by updated_at" do
    updated_at = create(:transaction).updated_at

    get "/api/v1/transactions/find?updated_at=#{updated_at}"

    transaction = JSON.parse(response.body)
    expect(response).to be_successful

    expected = Transaction.find(transaction["data"]["id"]).updated_at
    expect(expected).to eq(updated_at)
  end
end
