class Api::V1::Customers::RandomController < ApplicationController
  def show
    render json: CustomerSerializer.new(pick_one(Customer))
  end
end
