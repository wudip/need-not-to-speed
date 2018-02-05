require 'view/view_layer'
require 'model/controls/controls_model'
require 'model/game/game'

# Need not to speed game
module NeedNotToSpeed
  # Class representing the whole game and everything related to it.
  # It also contains objects to draw game window, listen to key events,
  # and draw menus.
  class NeedNotToSpeed
    attr_accessor :current_level
    def start
      @view_layer = View::ViewLayer.new
      @controls_model = ControlsModel.new(@view_layer, self)
      @current_level = 0
      @view_layer.show
    end

    def start_game
      @controls_model.display_loader
      if !@game.nil? && @current_level == @game.level
        @game.start
      else
        new_game
      end
    end

    def new_game
      Thread.new do # Because of loading screen
        @game = Game::Game.new(@view_layer, self, @current_level)
        @game.start
      end
    end

    def win_game
      @controls_model.win_game
    end

    def quit_game
      @controls_model.quit_game
    end

    def exit
      @view_layer.close
    end
  end
end
