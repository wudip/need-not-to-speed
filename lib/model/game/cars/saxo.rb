require 'model/game/cars/car'
require 'model/game/cars/light'
require 'model/game/cars/rotating_front_light'

module NeedNotToSpeed
  module Game
    # Something that should look and behave like Cintroen Saxo
    class Saxo < Car
      class << self
        def boundaries
          [[0, 43], [1, 35], [0, 30], [4, 53], [28, 54], [68, 55], [73, 59],
           [111, 54], [114, 51], [116, 45], [117, 36], [117, 32], [0, 16],
           [1, 24], [4, 6], [28, 5], [68, 4], [73, 0], [111, 5], [114, 8],
           [116, 14], [117, 23], [117, 27]]
        end
      end
      # Creates new Saxo car
      # @param x [Integer] horizontal position of the car
      # @param y [Integer] vertical position of the car
      def initialize(x, y)
        super(x, y)
        @img_path = 'saxo'
        @acceleration = 0.15
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
        @wheels_front = 22
        @wheels_rear = 100
      end

      # Places lights on the car
      def initialize_lights
        @lights.push(Light.new(self, 55, 14))
        @lights.push(Light.new(self, 55, -14))
      end
    end
  end
end
