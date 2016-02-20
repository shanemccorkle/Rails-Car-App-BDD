class SimulatorController < ApplicationController
  def status
    @car = YAML.load(cookies[:car])
  end

  def togglelights
    @car = YAML.load(cookies[:car])
    @car.light_toggle
    cookies[:car] = @car.to_yaml
    redirect_to "/simulator/status"
  end

  def speedup
    @car = YAML.load(cookies[:car])
    @car.accelerate
    cookies[:car] = @car.to_yaml
    redirect_to "/simulator/status"
  end

  def slowdown
    @car = YAML.load(cookies[:car])
    @car.brake
    cookies[:car] = @car.to_yaml
    redirect_to "/simulator/status"
  end

  def parkingbrake
    @car = YAML.load(cookies[:car])
    @car.parkbrake(params[:parking_brake])
    cookies[:car] = @car.to_yaml
    redirect_to "/simulator/status"
  end
end
