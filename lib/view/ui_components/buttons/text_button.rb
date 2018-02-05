require 'view/ui_components/buttons/button'

module NeedNotToSpeed
  module View
    # Encapsulates all actions related to displaying things on the screen.
    # No another class in view layer except for this one should be used
    # by another layer.
    class TextButton < Button
      attr_accessor :font_color
      def initialize(title, name, position, size)
        super(name, position, size)
        @title = title
        compute_message
        @font_color = Gosu::Color::BLUE
      end

      def compute_message
        font_size = 30
        @message = Gosu::Image.from_text(@title, font_size)
        @font_x = @pos_x + (@width - @message.width) / 2
        @font_y = @pos_y + (@height - @message.height) / 2
      end

      def draw
        super
        @message.draw(@font_x, @font_y, 6, 1, 1, @font_color)
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
end
