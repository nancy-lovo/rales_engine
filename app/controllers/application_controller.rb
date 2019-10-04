class ApplicationController < ActionController::API
  def pick_one(model)
    model.limit(1).order("RANDOM()")
  end
end
