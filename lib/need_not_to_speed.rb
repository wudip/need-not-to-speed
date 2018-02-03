require 'view/view_layer'
require 'model/controls/controls_model'
require 'model/game/game'

module NeedNotToSpeed
  # Class representing the whole game.
  class NeedNotToSpeed
    attr_accessor :current_level
    def start
      @view_layer = ViewLayer.new
      @controls_model = ControlsModel.new(@view_layer, self)
      @current_level = 0
      @view_layer.show
    end

    def start_game
      @controls_model.display_loader
      Thread.new { # Because of loading screen
        @game = Game.new(@view_layer, self, @current_level)
      }
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
