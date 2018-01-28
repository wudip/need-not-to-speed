require 'view/game_window'

module NeedNotToSpeed
  class LoaderScreen
    @loader_width = 500
    @loader_height = 20
    @border_width = 3
    class << self
      attr_reader :loader_width, :loader_height, :border_width
    end
    attr_reader :buttons

    def initialize(window)
      @window = window
      @progress = 0
      @progress_goal = 10
      @x = (window.width - self.class.loader_width) / 2
      @y = (window.height - self.class.loader_height) / 2
      @outer_x = @x - self.class.border_width
      @outer_y = @y - self.class.border_width
      @outer_width = self.class.loader_width + 2 * self.class.border_width
      @outer_height = self.class.loader_height + 2 * self.class.border_width
      @bg_color = Gosu::Color::BLACK
      @fg_color = Gosu::Color::WHITE
    end

    def progress(done, total)
      @progress = done
      @progress_goal = total
    end

    def things_to_draw
      [self]
    end

    def draw(window)
      Gosu::draw_rect(@outer_x, @outer_y, @outer_width, @outer_height, @bg_color)
      fg_width = (@progress * self.class.loader_width) / @progress_goal
      Gosu::draw_rect(@x, @y, fg_width, self.class.loader_height, @fg_color)
    end
  end
end
