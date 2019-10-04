class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find_by(invoice_item_params))
  end

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice_item_params))
  end

  private

  def invoice_item_params
    if params['unit_price']
      if params['unit_price'].include? "."
        params['unit_price'] = params['unit_price'].tr('.', '').to_i
      end
      params['unit_price'] = params['unit_price'].to_i
    end
    params.permit(:id, :item_id, :invoice_id, :unit_price, :quantity, :created_at, :updated_at)
  end
end
