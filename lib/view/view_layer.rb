require 'view/game_window'
require 'view/menu'

module NeedNotToSpeed
  # Encapsulates all actions related to displaying things on the screen.
  # No another class in view layer except for this one should be used
  # by another layer.
  class ViewLayer
    @button_width = 300
    @button_height = 50
    @button_padding = 20
    @window_width = 1280
    @window_height = 846
    class << self
      attr_reader :menu_button_width, :menu_button_height, :window_width, :window_height, :menu_button_padding
    end
    attr_writer :handler

    def initialize
      width = self.class.window_width
      height = self.class.window_height
      @window = GameWindow.new(self, width, height)
      @menu = Menu.new(@window)
      @handler = nil
    end

    # @return [List] list of all things that should be drawed in the windos
    def things_to_draw
      [@menu.things_to_draw].flatten
    end

    def show
      @window.show
    end

    # @param [List] buttons list of buttons. Every button is encoded by
    # a hash containing this parameters: title (what's written on the button)
    # and name (some short identifier of the button)
    def display_menu(buttons)
      @menu.buttons = buttons
    end

    def handle_key_up(key)
      return if @handler.nil?
    end

    def handle_mouse_down(key, x, y)
      return if @handler.nil?
      btn = @menu.find_button(x, y)
      return @handler.click_button(btn) unless btn.nil?
      # return @handler.click_key_right if key == Gosu::MS_RIGHT
      # @handler.click_key_left
    end

    def close
      @window.close
    end
  end
end