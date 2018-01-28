require 'model/game/map'
require 'model/game/player_car'

module NeedNotToSpeed
  # Class controlling whole game. It computes every object's position, it's
  # position, stores score and so on. It also sends data to display to the
  # view layer.
  class Game
    # @param [ViewLayer] displayer object that displays all game data on
    # the screen
    def initialize(displayer)
      @displayer = displayer
      @map = Map.new
      @active_objects = []
      @car = PlayerCar.new
      displayer.init_game(@active_objects, [@car])
      @displayer.handler = self
    end

    def update
      @active_objects.each do |object|
        object.update
      end
      @car.update
    end

    def click_button(btn)
    end

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
  end
end
