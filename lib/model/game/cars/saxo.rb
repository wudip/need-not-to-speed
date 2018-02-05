require 'model/game/cars/car'
require 'model/game/cars/light'
require 'model/game/cars/rotating_front_light'

module NeedNotToSpeed
  module Game
    # A car, either player's car or AI car
    class Saxo < Car
      class << self
        def boundaries
          [[0, 43], [1, 35], [0, 30], [4, 53], [28, 54], [68, 55], [73, 59],
           [111, 54], [114, 51], [116, 45], [117, 36], [117, 32], [0, 16],
           [1, 24], [4, 6], [28, 5], [68, 4], [73, 0], [111, 5], [114, 8],
           [116, 14], [117, 23], [117, 27]]
        end
      end
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
end