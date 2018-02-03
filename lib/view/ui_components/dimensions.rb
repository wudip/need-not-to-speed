module NeedNotToSpeed
  # Represents coordinates of a point in 2D space
  class Dimensions
    attr_accessor :width, :height
    def initialize(width, height)
      @width = width
      @height = height
    end
  end
end
