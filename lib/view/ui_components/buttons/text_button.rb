require 'view/ui_components/buttons/button'

module NeedNotToSpeed
  module View
    # A button with a text
    class TextButton < Button
      DEFAULT_FONT_COLOR = Gosu::Color::WHITE
      attr_accessor :font_color
      def initialize(title, name, position, size)
        super(name, position, size)
        @title = title
        compute_message
        @font_color = DEFAULT_FONT_COLOR
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
