module NeedNotToSpeed
  module Game
    # A light placed on a car
    class Light
      # Creates new light
      # @param car [Car] car to be placed on
      # @param x [Integer] x position of the light (relative to car's rotation
      # center when the car is drawn as pointing right)
      # @param y [Integer] y position of the light (relative to car's center)
      def initialize(car, x, y)
        @offset_x = x
        @offset_y = y
        @car = car
      end

      # @return [Integer] horizontal position of the light
      def x
        base = @car.pos_x + @offset_x * Math.cos(@car.rotation)
        base + @offset_y * Math.sin(@car.rotation)
      end

      # @return [Integer] vertical position of the light
      def y
        base = @car.pos_y + @offset_x * Math.sin(@car.rotation)
        base - @offset_y * Math.cos(@car.rotation)
      end

      # @return [Float] rotation of the light (in radians)
      def rotation
        @car.rotation
      end
    end
  end
end