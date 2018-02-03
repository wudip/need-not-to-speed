require 'view/game_window'

module NeedNotToSpeed
  # Represent screen displayed after 'Start game' button click but before
  # loading all game components
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
      compute_placement(window)
      @bg_color = Gosu::Color::BLACK
      @fg_color = Gosu::Color::WHITE
    end

    def compute_placement(window)
      @pos_x = (window.width - self.class.loader_width) / 2
      @pos_y = (window.height - self.class.loader_height) / 2
      compute_outer_placement
    end

    def compute_outer_placement
      compute_outer_position
      compute_outer_dimensions
    end

    def compute_outer_position
      @outer_x = @pos_x - self.class.border_width
      @outer_y = @pos_y - self.class.border_width
    end

    def compute_outer_dimensions
      @outer_width = self.class.loader_width + 2 * self.class.border_width
      @outer_height = self.class.loader_height + 2 * self.class.border_width
    end

    def progress(done, total)
      @progress = done
      @progress_goal = total
    end

    def things_to_draw
      [self]
    end

    def draw
      Gosu.draw_rect(@outer_x, @outer_y, @outer_width, @outer_height, @bg_color)
      fg_width = (@progress * self.class.loader_width) / @progress_goal
      fg_height = self.class.loader_height
      Gosu.draw_rect(@pos_x, @pos_y, fg_width, fg_height, @fg_color)
    end
  end
end
