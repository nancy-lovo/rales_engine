class Api::V1::Transactions::RandomController < ApplicationController
  def show
    render json: TransactionSerializer.new(pick_one(Transaction))
  end
end
