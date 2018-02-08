module NeedNotToSpeed
  module Game
    # Front (rotatable) wheels of a car
    class Wheels
      attr_reader :rotation
      # Maximum possible rotation of the wheels (in radians)
      MAX_ROTATION = 1.07
      # Creates new wheels object
      def initialize
        @rotation = 0
        @max_rotation = MAX_ROTATION
      end

      # Makes wheels straight (not turning right nor left)
      def straighten
        @rotation = 0
      end

      # Makes wheels turn left as much as possible
      def turn_left
        @rotation = -@max_rotation
      end

      # Makes wheels turn right as much as possible
      def turn_right
        @rotation = @max_rotation
      end
    end
  end
end