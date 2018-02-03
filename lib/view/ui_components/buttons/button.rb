require 'view/game_window'

module NeedNotToSpeed
  # Encapsulates all actions related to displaying things on the screen.
  # No another class in view layer except for this one should be used
  # by another layer.
  class Button
    attr_accessor :color
    attr_reader :name
    def initialize(name, position, size)
      @name = name
      @pos_x = position.pos_x
      @pos_y = position.pos_y
      @width = size.width
      @height = size.height
      compute_message
      @color = Gosu::Color::GREEN
    end

    def draw
      Gosu.draw_rect(@pos_x, @pos_y, @width, @height, @color, 5)
    end

    def inside_button?(x, y)
      x1 = @pos_x
      y1 = @pos_y
      x2 = x1 + @width
      y2 = y1 + @height
      x >= x1 && x <= x2 && y >= y1 && y <= y2
    end
  end
end
