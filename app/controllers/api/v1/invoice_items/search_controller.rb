class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find_by(invoice_item_params))
  end

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice_item_params))
  end

  private

  def invoice_item_params
    params.permit(:id, :item_id, :invoice_id, :unit_price, :quantity, :created_at, :updated_at)
  end
end
