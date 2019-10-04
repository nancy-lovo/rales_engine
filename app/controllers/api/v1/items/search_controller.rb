class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.order_items.find_by(item_params))
  end

  def index
    render json: ItemSerializer.new(Item.order_items.where(item_params))
  end

  private

  def item_params
    if params['unit_price']
      if params['unit_price'].include? "."
        params['unit_price'] = params['unit_price'].tr('.', '').to_i
      end
      params['unit_price'] = params['unit_price'].to_i
    end
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
