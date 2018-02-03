require 'model/game/map'
require 'model/game/player_car'
require 'model/game/level/level'

module NeedNotToSpeed
  # Class controlling whole game. It computes every object's position, it's
  # position, stores score and so on. It also sends data to display to the
  # view layer.
  class Game
    # @param [ViewLayer] viewer object that displays all game data on
    # the screen
    def initialize(viewer, event_handler)
      @viewer = viewer
      @event_handler = event_handler
      level = Level.new(0.to_s)
      x, y = level.start_position
      @map = level.map
      @active_objects = @map.active_objects
      @car = PlayerCar.new(x, y)
      viewer.init_game(self, @map.objects, [@car])
      @viewer.handler = self
    end

    def update
      @active_objects.each(&:update)
      @car.update
      collision_spot = @map.check_collision(@car)
      crash(collision_spot) unless collision_spot.nil?
    end

    def crash(collision_spot)
      @viewer.display_collision(collision_spot)
      @event_handler.quit_game
    end

    def click_button(_button) end

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
      @car.pos_x
    end

    def translation_y
      @car.pos_y
    end
  end
end
