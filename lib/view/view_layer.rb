require 'view/game_window'

module NeedNotToSpeed
  # Encapsulates all actions related to displaying things on the screen.
  # No another class in view layer except for this one should be used
  # by another layer.
  class ViewLayer
    def initialize
      @window = GameWindow.new
      @window.show
    end

    def display_menu
      puts 'Display menu'
    end
  end
end