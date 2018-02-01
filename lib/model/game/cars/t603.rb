require 'model/game/cars/car'
require 'model/game/cars/light'
require 'model/game/cars/rotating_front_light'

module NeedNotToSpeed
  # A car, either player's car or AI car
  class T603 < Car
    @boundaries = [[-75, 29], [75, 29], [-75, -29], [75, -29]]
    def initialize(x, y)
      super(x, y)
      @width = 150
      @height = 48
      @img_path = 't603'
      @wheels_front = 31
      @wheels_rear = 126
      @acceleration = 0.1
      @speed_max = 4
      @slowing_coefficient = 0.3 * @acceleration
      @speed_reverse_min = -2
      compute_wheelbase
      initialize_lights
    end

    def initialize_lights
      @lights.push(Light.new(self, 90, 8))
      @lights.push(RotatingFrontLight.new(self, 90, 0))
      @lights.push(Light.new(self, 90, -8))
    end
  end
end
