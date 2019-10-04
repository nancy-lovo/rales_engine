class Api::V1::InvoiceItems::RandomController < ApplicationController
  def show
    render json: InvoiceItemSerializer.new(pick_one(InvoiceItem))
  end
end
