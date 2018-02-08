require 'model/game/cars/car'
require 'model/game/cars/light'
require 'model/game/cars/rotating_front_light'

module NeedNotToSpeed
  module Game
    # Car similar to Tatra 603
    class T603 < Car
      @boundaries = [[-75, 29], [75, 29], [-75, -29], [75, -29]]
      # Creates new Saxo car
      # @param x [Integer] horizontal position of the car
      # @param y [Integer] vertical position of the car
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

      private

      # Places lights on the car
      def initialize_lights
        @lights.push(Light.new(self, 90, 8))
        @lights.push(RotatingFrontLight.new(self, 90, 0))
        @lights.push(Light.new(self, 90, -8))
      end
    end
  end
end