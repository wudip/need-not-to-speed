require 'model/game/cars/car_state'
require 'model/game/crashable'

module NeedNotToSpeed
  module Game
    # Front (rotatable) wheels of a car
    class Wheels
      attr_reader :rotation

      MAX_ROTATION = 1.07
      def initialize
        @rotation = 0
        @max_rotation = MAX_ROTATION
      end

      def straighten
        @rotation = 0
      end

      def turn_left
        @rotation = -@max_rotation
      end

      def turn_right
        @rotation = @max_rotation
      end

    end
  end
end