require 'model/game/car_state'

module NeedNotToSpeed
  # A car, either player's car or AI car
  class Car
    attr_reader :x, :y, :width, :height, :img_path, :state
    def initialize(x, y, img_path, wheels_front, wheels_rear)
      @x = x
      @y = y
      @width = 150
      @height = 50
      @img_path = img_path
      @wheels_front = wheels_front
      @wheels_rear = wheels_rear
      @acceleration = 0.05
      @rotation = -Math::PI / 2
      @speed_max = 10
      @slowing_coefficient = 0.3 * @acceleration
      @turning_constant = 0.1
      @speed_reverse_min = -5
      @speed = 0
      @direction = 0
      @velocity_x = 0
      @velocity_y = 0
      @state = CarState.new
    end

    def speed_up
      @speed += @acceleration
      @speed = @speed_max if @speed > @speed_max
    end

    def slow_down
      @speed -= @acceleration
      @speed = @speed_reverse_min if @speed < @speed_reverse_min
    end

    def slow_down_a_bit
      @speed -= @slowing_coefficient
      @speed = 0 if @speed < 0
    end

    def brake
      @speed -= @acceleration
      @speed = 0 if @speed < 0
    end

    def turn_left
      @rotation += @turning_constant
    end

    def turn_right
      @rotation -= @turning_constant
    end

    def update
      speed_up if @state.speeding_up
      slow_down_a_bit unless @state.speeding_up || @state.slowing_down
      slow_down if @state.slowing_down
      turn_left if @state.turning_left
      turn_right if @state.turning_right
      update_position
    end

    def update_position
      @x += @speed * Math.cos(@rotation)
      @y += @speed * Math.sin(@rotation)
    end
  end
end
