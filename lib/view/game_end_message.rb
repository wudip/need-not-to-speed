require 'view/ui_components/buttons/text_button'

module NeedNotToSpeed
  # Shows message about end of the game
  class GameEndMessage
    def initialize(center_x, center_y)
      title = 'Game end'
      name = 'whatever'
      size = Dimensions.new(200, 50)
      @button = TextButton.new(title, name, Point.new(center_x, center_y), size)
    end

    def draw
      @button.draw
    end
  end
end
