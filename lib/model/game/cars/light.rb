module NeedNotToSpeed
  # A light placed on a car
  class Light
    def initialize(car, x, y)
      @offset_x = x
      @offset_y = y
      @car = car
    end

    def x
      base = @car.x + @offset_x * Math.cos(@car.rotation)
      base + @offset_y * Math.sin(@car.rotation)
    end

    def y
      base = @car.y + @offset_x * Math.sin(@car.rotation)
      base - @offset_y * Math.cos(@car.rotation)
    end

    def rotation
      @car.rotation
    end
  end
end
