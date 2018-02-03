require 'view/game_window'

module NeedNotToSpeed
  # Represent screen displayed after 'Start game' button click but before
  # loading all game components
  class LoaderScreen
    ROTATION_STEP = -2
    MAX_ROTATION = 360
    IMG_PATH = 'lib/images/roundabout.png'.freeze
    def initialize(window)
      @bg_color = Gosu::Color::WHITE
      @window = window
      @rotation = 0
      @image = Gosu::Image.new(IMG_PATH)
    end

    def things_to_draw
      [self]
    end

    def draw
      Gosu.draw_rect(0, 0, @window.width, @window.height, @bg_color)
      x = @window.width / 2
      y = @window.height / 2
      @image.draw_rot(x, y, 2, @rotation)
      @rotation += ROTATION_STEP
      @rotation -= MAX_ROTATION if @rotation >= MAX_ROTATION
      @rotation += MAX_ROTATION if @rotation < 0
    end
  end
end
