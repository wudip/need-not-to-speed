require 'gosu'

module NeedNotToSpeed
  module View
    # A window that can be displayed by `show` method and display some stuff
    # on user's screen
    class Window < Gosu::Window
      BACKGROUND_COLOR = Gosu::Color.argb(0xff_005643)
      def initialize(handler, width, height)
        @width = width
        @height = height
        super(width, height, false)
        self.caption = 'Need Not To Speed'
        @handler = handler
      end

      def draw
        Gosu.draw_rect(0, 0, @width, @height, BACKGROUND_COLOR)
        @handler.things_to_draw.each(&:draw)
      end

      def needs_cursor?
        true
      end

      def button_down(key)
        @handler.handle_key_down(key) unless mouse_key?(key)
      end

      def button_up(key)
        return @handler.handle_key_up(key) unless mouse_key?(key)
        @handler.handle_mouse_down(key, mouse_x, mouse_y)
      end

      def display_button(button)
        button
      end

      def update
        @handler.update
      end

      private

      def mouse_key?(key)
        [Gosu::MS_LEFT, Gosu::MS_RIGHT].include? key
      end
    end
  end
end
