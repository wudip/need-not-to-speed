require 'view/view_layer'
require 'model/controls/controls_model'

module NeedNotToSpeed
  # Class representing the whole game.
  class NeedNotToSpeed
    def start
      @view_layer = ViewLayer.new
      @controls_model = ControlsModel.new(@view_layer)
    end
  end
end
