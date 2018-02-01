require 'model/game/map'
require 'model/game/player_car'

module NeedNotToSpeed
  # Class controlling whole game. It computes every object's position, it's
  # position, stores score and so on. It also sends data to display to the
  # view layer.
  class Game
    # @param [ViewLayer] displayer object that displays all game data on
    # the screen
    def initialize(displayer, event_handler)
      @displayer = displayer
      @event_handler = event_handler
      @map = Map.new
      @active_objects = []
      @car = PlayerCar.new
      displayer.init_game(self, @active_objects, [@car])
      @displayer.handler = self
    end

    def update
      @active_objects.each(&:update)
      @car.update
      collision_spot = @map.check_collision(@car)
      crash(collision_spot) unless collision_spot.nil?
    end

    def crash(collision_spot)
      @displayer.display_collision(collision_spot)
      @event_handler.quit_game
    end

    def click_button(button) end

    def handle_key_down(key)
      case key
      when Gosu::KbLeft
        @car.state.turning_left = true
      when Gosu::KbRight
        @car.state.turning_right = true
      when Gosu::KbUp
        @car.state.speeding_up = true
      when Gosu::KbDown
        @car.state.slowing_down = true
      when Gosu::KbSpace
        @car.state.braking = true
      end
    end

    def handle_key_up(key)
      case key
      when Gosu::KbLeft
        @car.state.turning_left = false
      when Gosu::KbRight
        @car.state.turning_right = false
      when Gosu::KbUp
        @car.state.speeding_up = false
      when Gosu::KbDown
        @car.state.slowing_down = false
      when Gosu::KbSpace
        @car.state.braking = false
      when Gosu::KbL
        @car.state.lights_on = !@car.state.lights_on
      end
    end

    def translation_x
      @car.x
    end

    def translation_y
      @car.y
    end
  end
end
