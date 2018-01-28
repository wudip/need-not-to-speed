module NeedNotToSpeed
  # A light placed on a car
  class RotatingFrontLight < Light

    def initialize(car, x, y)
      super(car, x, y)
      @car = car
    end

    def rotation
      @car.rotation + @car.wheel_rotation / 4
    end
  end
end
