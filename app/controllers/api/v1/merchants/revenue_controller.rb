class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end

  def show
    render json: RevenueSerializer.new(Merchant.total_revenue_by_date(params[:date]))
  end
end
