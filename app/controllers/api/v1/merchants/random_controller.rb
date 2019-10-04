class Api::V1::Merchants::RandomController < ApplicationController
  def show
    render json: MerchantSerializer.new(pick_one(Merchant))
  end
end
