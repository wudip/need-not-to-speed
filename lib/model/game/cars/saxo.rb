require 'model/game/cars/car'
require 'model/game/cars/light'
require 'model/game/cars/rotating_front_light'

module NeedNotToSpeed
  # A car, either player's car or AI car
  class Saxo < Car
    def initialize(x, y)
      super(x, y)
      @width = 150
      @height = 48
      @img_path = 'saxo'
      @wheels_front = 22
      @wheels_rear = 100
      @acceleration = 0.15
      @speed_max = 4
      @slowing_coefficient = 0.3 * @acceleration
      @speed_reverse_min = -2
      compute_wheelbase
      initialize_lights
    end

    def initialize_lights
      @lights.push(Light.new(self, 55, 14))
      @lights.push(Light.new(self, 55, -14))
    end
  end
end
