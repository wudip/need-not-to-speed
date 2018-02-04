require 'model/game/cars/car_state'
require 'model/game/cars/wheels'
require 'model/game/crashable'

module NeedNotToSpeed
  # A car, either player's car or AI car
  class Car
    class << self
      def boundaries
        [[0, 0]]
      end
    end
    attr_reader :pos_x, :pos_y, :width, :height, :rotation, :img_path, :state,
                :wheelbase_center, :lights, :speed

    def initialize(pos_x, pos_y)
      set_position(pos_x, pos_y)
      set_default_values
      @state = CarState.new
      @core = Crashable.new(self.class.boundaries)
      @wheels = Wheels.new
      compute_wheelbase
      @lights = []
    end

    def set_position(pos_x, pos_y)
      @pos_x = pos_x.to_f
      @pos_y = pos_y.to_f
    end

    def set_default_values
      @width = 150
      @height = 50
      @img_path = nil
      @wheels_front = 35
      @wheels_rear = 122
      @acceleration = 0.05
      @rotation = -Math::PI / 2
      @speed_max = 0.05
      @slowing_coefficient = 0.5 * @acceleration
      @speed_reverse_min = -5
      @speed = 0
      @velocity_x = 0
      @velocity_y = 0
    end

    def compute_wheelbase
      @wheelbase = @wheels_rear - @wheels_front
      @wheelbase_center = 1 - ((@wheels_front + @wheels_rear) / 2).to_f / @width
      x_center = (width - (@wheels_front + @wheels_rear)) / 2
      @core.center_points(x_center, 0)
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
      @last_stop = { x: @pos_x, y: @pos_y } if @speed.to_i.zero?
    end

    def manage_rotation
      @wheels.straighten
      turn_left if @state.turning_left && !@state.turning_right
      turn_right if @state.turning_right && !@state.turning_left
    end

    def turn_left
      @wheels.turn_left
      ta = turning_angle
      @rotation -= ta if @speed > 0
      @rotation += ta if @speed < 0
      check_rotation_constraints
    end

    def turn_right
      @wheels.turn_right
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
      cos_wr = Math.cos(wheels_angle_concave)
      squares = @wheelbase * @wheelbase + delta * delta
      c2 = squares - 2 * @wheelbase * delta * cos_wr
      c = Math.sqrt(c2)
      Math.acos((@wheelbase - delta * cos_wr) / c)
    end

    def update_position
      @pos_x += @speed * Math.cos(@rotation)
      @pos_y += @speed * Math.sin(@rotation)
    end

    def active_lights
      state.lights_on ? @lights : []
    end

    def get_pixels
      @core.get_pixels(@pos_x, @pos_y, @rotation)
    end

    def last_stop
      [@last_stop[:x], @last_stop[:y]]
    end

    private

    def wheels_angle_concave
      Math::PI - @wheels.rotation
    end
  end
end
