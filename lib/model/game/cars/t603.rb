require 'model/game/cars/car'
require 'model/game/cars/light'
require 'model/game/cars/rotating_front_light'

module NeedNotToSpeed
  module Game
    # Car similar to Tatra 603
    class T603 < Car
      class << self
        def boundaries
          [[0, 17], [1, 8], [4, 4], [14, 3], [35, 2], [55, 1], [82, 0],
           [98, 0], [117, 0], [126, 0], [130, 1], [135, 1], [140, 4],
           [143, 7], [146, 12], [149, 15], [148, 19], [148, 25],
           [0, 40], [1, 49], [4, 53], [14, 54], [35, 55], [55, 56], [82, 57],
           [98, 57], [117, 57], [126, 57], [130, 56], [135, 56], [140, 53],
           [143, 50], [146, 45], [149, 39], [148, 38], [148, 32]]
        end
      end
      # Creates new T603 car
      # @param x [Integer] horizontal position of the car
      # @param y [Integer] vertical position of the car
      def initialize(x, y)
        super(x, y)
        @img_path = 't603'
        @acceleration = 0.1
        @speed_max = 4
        @slowing_coefficient = 0.3 * @acceleration
        @speed_reverse_min = -2
        initialize_lights
      end

      protected

      # Sets up stuff related to dimensions of the car
      def initialize_dimensions
        @width = 150
        @height = 48
        @wheels_front = 31
        @wheels_rear = 126
      end

      # Places lights on the car
      def initialize_lights
        @lights.push(Light.new(self, 90, 8))
        @lights.push(RotatingFrontLight.new(self, 90, 0))
        @lights.push(Light.new(self, 90, -8))
      end
    end
  end
end
