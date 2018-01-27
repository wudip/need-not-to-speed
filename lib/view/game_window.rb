require 'gosu'

module NeedNotToSpeed
  # A window that can be displayed by `show` method and display some stuff
  # on user's screen
  class GameWindow < Gosu::Window
    def initialize(handler, width, height)
      @width = width
      @height = height
      super(width, height, false)
      self.caption = 'Need Not To Speed'
      @handler = handler
    end

    def draw
      Gosu::draw_rect(0, 0, @width, @height, Gosu::Color::RED)
      @handler.things_to_draw.each do |elem|
        elem.draw(self)
      end
    end

    def needs_cursor?
      true
    end

    def button_up(key)
      if [Gosu::MS_LEFT, Gosu::MS_RIGHT].include? key
        return @handler.handle_mouse_down(key, mouse_x, mouse_y)
      end
      @handler.handle_key_up(key)
    end

    def display_button(button)
      button
    end
  end
end
