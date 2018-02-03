require 'view/ui_components/buttons/button'
require 'view/ui_components/point'
require 'view/ui_components/dimensions'
require 'view/ui_components/image_component'
require 'view/game_window'

module NeedNotToSpeed
  # Encapsulates all actions related to displaying things on the screen.
  # No another class in view layer except for this one should be used
  # by another layer.
  class Menu
    IMG_GAME_COMPLETED_PATH = 'msg_game_completed'
    @button_width = 300
    @button_height = 50
    @button_padding = 20
    class << self
      attr_reader :button_width, :button_height, :button_padding
    end
    attr_reader :buttons

    def initialize(window)
      @window = window
      @buttons = []
    end

    def things_to_draw
      @buttons
    end

    # @param [List] buttons list of buttons. Every button is encoded by
    # a hash containing this parameters: title (what's written on the button)
    # and name (some short identifier of the button)
    def buttons=(buttons)
      y = button_block_position_top(buttons)
      x = button_block_position_left
      buttons.each do |button|
        add_button(button[:title], button[:name], x, y)
        y += self.class.button_height + self.class.button_padding
      end
    end

    def compute_block_height(buttons)
      number_of_buttons = buttons.length
      self.class.button_height * number_of_buttons +
        self.class.button_padding * (number_of_buttons - 1)
    end

    def add_button(title, name, x, y)
      width = self.class.button_width
      height = self.class.button_height
      btn = TextButton.new(title, name, Point.new(x, y), Dimensions.new(width, height))
      @buttons.push(btn)
    end

    def find_button(x, y)
      @buttons.each do |btn|
        return btn.name if btn.inside_button?(x, y)
      end
      nil
    end

    def display_game_completed_message
      img = ImageComponent.new(IMG_GAME_COMPLETED_PATH, 20, 20)
      @buttons.push(img)
    end

    private

    def button_block_position_top(buttons)
      button_block_height = compute_block_height(buttons)
      (ViewLayer.window_height - button_block_height) / 2
    end

    def button_block_position_left
      (ViewLayer.window_width - self.class.button_width) / 2
    end
  end
end
