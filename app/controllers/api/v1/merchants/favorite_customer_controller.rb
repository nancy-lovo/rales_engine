class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    render json: CustomerSerializer.new(Merchant.favorite_customer(merchant.id))
  end
end
