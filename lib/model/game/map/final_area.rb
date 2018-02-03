module NeedNotToSpeed
  # Loads map details from files
  class FinalArea
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
