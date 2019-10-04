class Api::V1::Items::RandomController < ApplicationController
  def show
    render json: ItemSerializer.new(pick_one(Item))
  end
end
