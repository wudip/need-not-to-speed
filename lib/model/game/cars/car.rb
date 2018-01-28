require 'model/game/cars/car_state'

module NeedNotToSpeed
  # A car, either player's car or AI car
  class Car
    attr_reader :x, :y, :width, :height, :rotation, :img_path, :state,
                :wheelbase_center, :wheel_rotation, :lights
    def initialize(x, y)
      @x = x.to_f
      @y = y.to_f
      @width = 150
      @height = 50
      @img_path = nil
      @wheels_front = 35
      @wheels_rear = 122
      @acceleration = 0.05
      @rotation = -Math::PI / 2
      @wheel_rotation = 0
      @max_wheel_rotation = 1.07
      @speed_max = 0.05
      @slowing_coefficient = 0.5 * @acceleration
      @speed_reverse_min = -5
      @speed = 0
      @velocity_x = 0
      @velocity_y = 0
      @state = CarState.new
      compute_wheelbase
      @lights = []
    end

    def compute_wheelbase
      @wheelbase = @wheels_rear - @wheels_front
      @wheelbase_center = 1 - (@wheels_front + @wheels_rear / 2).to_f / @width
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

    def update
      manage_speed
      manage_rotation
      update_position
    end

    def manage_speed
      speed_up if @state.speeding_up
      slow_down_a_bit unless @state.speeding_up || @state.slowing_down
      slow_down if @state.slowing_down
    end

    def manage_rotation
      @wheel_rotation = 0
      turn_left if @state.turning_left && !@state.turning_right
      turn_right if @state.turning_right && !@state.turning_left
    end

    def turn_left
      @wheel_rotation = -@max_wheel_rotation
      ta = turning_angle
      @rotation -= ta if @speed > 0
      @rotation += ta if @speed < 0
      check_rotation_constraints
    end

    def turn_right
      @wheel_rotation = @max_wheel_rotation
      ta = turning_angle
      @rotation += ta if @speed > 0
      @rotation -= ta if @speed < 0
      check_rotation_constraints
    end

    def check_rotation_constraints
      @rotation += 2 * Math::PI if rotation < 0
      @rotation -= 2 * Math::PI if rotation >= 2 * Math::PI
    end

    def turning_angle
      turning_angle_delta(@speed)
    end

    def turning_angle_delta(delta)
      cos_wr = Math.cos(Math::PI - @wheel_rotation)
      squares = @wheelbase * @wheelbase + delta * delta
      c2 = squares - 2 * @wheelbase * delta * cos_wr
      c = Math.sqrt(c2)
      Math.acos((@wheelbase - delta * cos_wr) / c)
    end

    def update_position
      @x += @speed * Math.cos(@rotation)
      @y += @speed * Math.sin(@rotation)
    end

    def active_lights
      state.lights_on ? @lights : []
    end
  end
end
