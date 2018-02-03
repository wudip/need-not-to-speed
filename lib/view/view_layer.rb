require 'view/game_view'
require 'view/game_window'
require 'view/ui_components/loader_screen'
require 'view/ui_components/menu'

module NeedNotToSpeed
  # Encapsulates all actions related to displaying things on the screen.
  # No another class in view layer except for this one should be used
  # by another layer.
  class ViewLayer
    @window_width = 1280
    @window_height = 846
    class << self; attr_reader :window_width, :window_height end
    attr_writer :handler

    def initialize
      width = self.class.window_width
      height = self.class.window_height
      @window = GameWindow.new(self, width, height)
      @menu = Menu.new(@window)
      @loader = LoaderScreen.new(@window)
      @game = GameView.new(nil, [], [])
      @mode = :menu
      @handler = nil
    end

    # @return [List] list of all things that should be drawed in the windos
    def things_to_draw
      return [@menu.things_to_draw].flatten if @mode == :menu
      return [@loader.things_to_draw].flatten if @mode == :loader
      return [@game.things_to_draw].flatten if @mode == :game
    end

    def show
      @window.show
    end

    # @param [List] buttons list of buttons. Every button is encoded by
    # a hash containing this parameters: title (what's written on the button)
    # and name (some short identifier of the button)
    def display_menu(buttons)
      @mode = :menu
      @menu.buttons = buttons
    end

    def display_loader(progress, progress_goal)
      @mode = :loader
      @loader.progress(progress, progress_goal)
    end

    def init_game(game, objects, cars)
      @game = GameView.new(game, objects, cars)
      @mode = :game
    end

    def handle_key_down(key)
      return if @handler.nil? || @mode != :game
      @handler.handle_key_down(key)
    end

    def handle_key_up(key)
      return if @handler.nil? || @mode != :game
      @handler.handle_key_up(key)
    end

    def handle_mouse_down(_key, x, y)
      return if @handler.nil?
      btn = nil
      btn = @menu.find_button(x, y) if @mode == :menu
      btn = @game.find_button(x, y) if @mode == :game
      return @handler.click_button(btn) unless btn.nil?
      # return @handler.click_key_right if key == Gosu::MS_RIGHT
      # @handler.click_key_left
    end

    def close
      @window.close
    end

    def update
      @handler.update unless @handler.nil?
    end

    def display_collision(collision_spot)
      @game.display_collision(collision_spot)
    end

    def display_game_end
      @game.display_end
    end
  end
end
