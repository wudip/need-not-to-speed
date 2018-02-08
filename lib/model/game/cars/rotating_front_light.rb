module NeedNotToSpeed
  module Game
    # A light placed on a car that rotates together with car's wheels
    class RotatingFrontLight < Light
      # Creates new light
      # @param car [Car] car to be placed on
      # @param x [Integer] x position of the light (relative to car's rotation
      # center when the car is drawn as pointing right)
      # @param y [Integer] y position of the light (relative to car's center)
      def initialize(car, x, y)
        super(car, x, y)
        @car = car
      end

      # @return [Float] rotation of the light (in radians)
      def rotation
        @car.rotation + @car.wheel_rotation / 4
      end
    end
  end
end