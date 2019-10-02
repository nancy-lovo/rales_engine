class Api::V1::Customers::SearchController < ApplicationController
  def show
    render json: CustomerSerializer.new(Customer.find_by(customer_params))
  end

  def show_all
    render json: CustomerSerializer.new(Customer.find_by(customer_params))
    # render json: Customer.find_by(customer_params), root: 'data', each_serializer: CustomerSerializer
  end

  private

  def customer_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
