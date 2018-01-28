require 'view/view_layer'
require 'model/controls/controls_model'
require 'model/game/game'

module NeedNotToSpeed
  # Class representing the whole game.
  class NeedNotToSpeed
    def start
      @view_layer = ViewLayer.new
      @controls_model = ControlsModel.new(@view_layer, self)
      @view_layer.show
    end

    def start_game
      @controls_model.display_loader
      @game = Game.new(@view_layer)
    end

    def quit_game
      @controls_model.display_menu
    end

    def exit
      @view_layer.close
    end
  end
end
