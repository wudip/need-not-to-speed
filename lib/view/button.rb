require 'view/button'
require 'view/game_window'

module NeedNotToSpeed
  # Encapsulates all actions related to displaying things on the screen.
  # No another class in view layer except for this one should be used
  # by another layer.
  class Button
    attr_reader :name
    def initialize(title, name, x, y, width, height)
      @title = title
      @name = name
      @x = x
      @y = y
      @width = width
      @height = height
      compute_message
      @color = Gosu::Color::GREEN
      @font_color = Gosu::Color::BLUE
    end

    def compute_message
      font_size = 30
      font_name = Gosu.default_font_name
      @message = Gosu::Image.from_text(@title, font_size)
      @font_x = @x + (@width - @message.width) / 2
      @font_y = @y + (@height - @message.height) / 2
    end

    def draw(window)
      Gosu::draw_rect(@x, @y, @width, @height, @color)
      @message.draw(@font_x, @font_y, 0, 1, 1,  @font_color)
    end

    def inside_button?(x, y)
      x1 = @x
      y1 = @y
      x2 = x1 + @width
      y2 = y1 + @height
      x >= x1 && x <= x2 && y >= y1 && y <= y2
    end
  end
end
