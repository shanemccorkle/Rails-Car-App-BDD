class CarController < ApplicationController
  def create
    if !params.has_key?(:make) || !params.has_key?(:modelyear) ||  params[:make].strip.empty? || params[:modelyear].strip.empty?
      render "/car/create"
    else
      car = Car.new(params[:make], params[:modelyear], params[:description])
      cookies[:car] = car.to_yaml
      redirect_to "/simulator/status"
    end
  end
end
