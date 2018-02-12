require 'view/ui_components/buttons/text_button'
require 'view/ui_components/buttons/radio_text_button'
require 'view/ui_components/support/point'
require 'view/ui_components/support/dimensions'
require 'view/ui_components/image_component'
require 'view/window'

module NeedNotToSpeed
  module View
    # Draws menu on the screen
    class Menu
      IMG_GAME_COMPLETED_PATH = 'msg_game_completed'.freeze
      BUTTON_WIDTH = 300
      BUTTON_HEIGHT = 50
      BUTTON_PADDING = 20
      attr_reader :buttons

      # Creates new menu object
      # @param window [Window] window on which the menu is placed
      def initialize(window)
        @window = window
        @buttons = []
        @radio_buttons = {}
      end

      # All objects (menu parts) that has to be drawn
      # @return [List] list of objects to draw
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
          rg = button.key?(:radio_group) ? button[:radio_group] : nil
          add_button(button[:title], button[:name], x, y, rg)
          y += BUTTON_HEIGHT + BUTTON_PADDING
        end
      end

      # Adds one button to the menu
      # @param [String] title what's written on the button
      # @param [String] name unique identifier of the menu
      # @param [Integer] x horizontal position of button's left edge
      # @param [Integer] y vertical position of button's top edge
      # @param [Symbol, nil] radio_group identifier of group the button
      # belong to in case it is radio button (or nil otherwise)
      def add_button(title, name, x, y, radio_group)
        point = Point.new(x, y)
        dimensions = Dimensions.new(BUTTON_WIDTH, BUTTON_HEIGHT)
        btn = create_button(title, name, point, dimensions, radio_group)
        @buttons.push(btn)
      end

      # Finds a button on specified position
      # @param x [Integer] horizontal position of the desired button
      # @param y [Integer] vertical position of the desired button
      # @return [String, nil] button's name or nil if there is no button
      def find_button(x, y)
        @buttons.each do |btn|
          next unless btn.inside_button?(x, y)
          if btn.respond_to?(:radio_group)
            unselect_radio_group(btn.radio_group)
            btn.select
          end
          return btn.name
        end
        nil
      end

      # Displays message telling user that he completed all the levels
      def display_game_completed_message
        img = ImageComponent.new(IMG_GAME_COMPLETED_PATH, 20, 20)
        @buttons.push(img)
      end

      private

      def compute_block_height(buttons)
        number_of_buttons = buttons.length
        BUTTON_HEIGHT * number_of_buttons +
          BUTTON_PADDING * (number_of_buttons - 1)
      end

      def button_block_position_top(buttons)
        button_block_height = compute_block_height(buttons)
        (ViewLayer.window_height - button_block_height) / 2
      end

      def button_block_position_left
        (ViewLayer.window_width - BUTTON_WIDTH) / 2
      end

      def create_button(title, name, point, dimensions, radio_group)
        is_ordinal = radio_group.nil?
        return TextButton.new(title, name, point, dimensions) if is_ordinal
        create_radio_button(title, name, point, dimensions, radio_group)
      end

      def create_radio_button(title, name, point, dimensions, radio_group)
        btn = RadioTextButton.new(title, name, point, dimensions, radio_group)
        if @radio_buttons.key?(radio_group)
          group = @radio_buttons[radio_group]
        else
          group = []
          @radio_buttons[radio_group] = group
          btn.select
        end
        group.push(btn)
        btn
      end

      def unselect_radio_group(group_name)
        return unless @radio_buttons.key?(group_name)
        @radio_buttons[group_name].each(&:unselect)
      end
    end
  end
end
