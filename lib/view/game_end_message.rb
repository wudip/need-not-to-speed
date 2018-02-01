require 'view/button'

module NeedNotToSpeed
  class GameEndMessage
    def initialize(center_x, center_y)
      @button = Button.new('Game end', 'whatever', center_x, center_y, 200, 50)
    end

    def draw(window)
      @button.draw(window)
    end
  end
end
