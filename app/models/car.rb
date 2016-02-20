class Car
  def initialize(make, model_year, descrip, carcolor="")
    @make = make
    @model_year = model_year
    @description = descrip
    @light = false
    @speed = 0
    @parkingbrake = "Off"
    @color = carcolor
  end

  def make
    return @make
  end

  def model_year
    return @model_year
  end

  def description
    return @description
  end

  def get_car
    return @color + " " + @model_year + " " + @make + "; " + @description
  end

  def light_status
    return @light
  end

  def light_toggle
    @light = !@light
  end

  def get_speed
    return @speed
  end

  def accelerate
    if @parkingbrake == "Off"
      @speed += 10
    end
  end

  def brake
    if @speed > 0
      @speed -= 10
    end
  end

  def parkingbrake?
    return @parkingbrake
  end

  def parkbrake(value)
    @speed = 0
    @parkingbrake = value

  end
end
