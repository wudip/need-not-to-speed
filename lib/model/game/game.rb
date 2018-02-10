require 'model/game/map/map'
require 'model/game/cars/saxo'
require 'model/game/level/level'

module NeedNotToSpeed
  # Need not to speed - actual game logic (one level) without any controls or
  # view layer
  module Game
    KEY_DOWN_ACTIONS = {
      Gosu::KbLeft => proc { |car| car.state.turning_left = true },
      Gosu::KbRight => proc { |car| car.state.turning_right = true },
      Gosu::KbUp => proc { |car| car.state.speeding_up = true },
      Gosu::KbDown => proc { |car| car.state.slowing_down = true },
      Gosu::KbSpace => proc { |car| car.state.braking = true }
    }.freeze
    KEY_UP_ACTIONS = {
      Gosu::KbLeft => proc { |car| car.state.turning_left = false },
      Gosu::KbRight => proc { |car| car.state.turning_right = false },
      Gosu::KbUp => proc { |car| car.state.speeding_up = false },
      Gosu::KbDown => proc { |car| car.state.slowing_down = false },
      Gosu::KbSpace => proc { |car| car.state.braking = false },
      Gosu::KbL => proc { |car| car.state.lights_on = !car.state.lights_on }
    }.freeze
    # Class controlling whole game. It computes every object's position, it's
    # position, stores score and so on. It also sends data to display to the
    # view layer.
    class Game
      attr_reader :level
      # Creates new game
      # @param [ViewLayer] viewer object that displays all game data on the
      # screen
      # @param [NeedNotToSpeed] event_handler handler object that handles
      # events beyond the game itself (game end, score, ...)
      # @param [Integer] level_number unique identifier of the level
      def initialize(viewer, event_handler, level_number)
        @viewer = viewer
        @event_handler = event_handler
        @level = level_number
        @level_object = Level.new(level_number.to_s)
        @map = @level_object.map
        @active_objects = @map.active_objects
      end

      # Starts the game from beginning
      def start
        x, y = @level_object.start_position
        init_player_car(x, y)
        @viewer.init_game(self, @map.objects, [@car])
        @viewer.handler = self
      end

      # Updates all map's objects and the player's car
      def update
        @active_objects.each(&:update)
        @car.update
        collision_spot = @map.check_collision(@car)
        crash(collision_spot) unless collision_spot.nil?
        win if @map.reached_end?(@car)
      end

      # Marks the game as completed and quits it
      def win
        @event_handler.win_game
      end

      def crash(collision_spot)
        @viewer.display_collision(collision_spot)
        @event_handler.quit_game
      end

      def click_button(_button) end

      def handle_key_down(key)
        KEY_DOWN_ACTIONS[key].call(@car)
      end

      def handle_key_up(key)
        KEY_UP_ACTIONS[key].call(@car)
      end

      def translation_x
        @car.pos_x
      end

      def translation_y
        @car.pos_y
      end

      private

      def init_player_car(x, y)
        @car = Saxo.new(x, y)
      end
    end
  end
end
