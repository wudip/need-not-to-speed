module NeedNotToSpeed
  module View
    # Represents coordinates of a point in 2D space
    class Point
      attr_accessor :pos_x, :pos_y
      def initialize(x, y)
        @pos_x = x
        @pos_y = y
      end
    end
  end
end
