module NeedNotToSpeed
  module View
    # Represents width and height of an object in 2D space
    class Dimensions
      attr_accessor :width, :height
      def initialize(width, height)
        @width = width
        @height = height
      end
    end
  end
end
