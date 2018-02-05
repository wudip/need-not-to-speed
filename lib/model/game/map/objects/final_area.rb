module NeedNotToSpeed
  module Game
    # Final area where car should go to end the level
    class FinalArea
      # Creates final area with specified parameters
      # @param x [Integer] beginning of the final area on horizontal axis
      # @param y [Integer] beginning of the final area on vertical axis
      # @param width [Integer] width of the area
      # @param height [Integer] height of the area
      def initialize(x, y, width, height)
        @x_beg = x
        @y_beg = y
        @x_end = x + width
        @y_end = y + height
      end

      # @return [Boolean] true if object is in the final area, false if not
      def inside?(object)
        x = object.pos_x
        y = object.pos_y
        x >= @x_beg && x < @x_end && y >= @y_beg && y < @y_end
      end
    end
  end
end