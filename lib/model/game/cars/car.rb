require 'model/game/cars/car_state'
require 'model/game/cars/wheels'
require 'model/game/crashable'
require 'model/game/moving_object'

module NeedNotToSpeed
  module Game
    # A car, either player's car or AI car
    class Car < MovingObject
      class << self
        def boundaries
          [[0, 0]]
        end
      end
      attr_reader :width, :height, :img_path, :state, :wheelbase_center,
                  :lights, :speed
      def initialize(pos_x, pos_y)
        super(pos_x, pos_y, -Math::PI / 2)
        set_default_values
        @state = CarState.new
        @core = Crashable.new(self.class.boundaries)
        @wheels = Wheels.new
        compute_wheelbase
        @lights = []
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
        update_last_stop
      end

      def manage_rotation
        @wheels.straighten
        turn_left if @state.turning_left && !@state.turning_right
        turn_right if @state.turning_right && !@state.turning_left
      end

      def turn_left
        @wheels.turn_left
        self.rotation -= turning_angle
      end

      def turn_right
        @wheels.turn_right
        self.rotation += turning_angle
      end

      def rotation=(rotation)
        @rotation = rotation
        @rotation += 2 * Math::PI if @rotation < 0
        @rotation -= 2 * Math::PI if @rotation >= 2 * Math::PI
      end

      def turning_angle
        return turning_angle_delta(@speed) if @speed > 0
        return -turning_angle_delta(@speed) if @speed < 0
        0
      end

      def turning_angle_delta(delta)
        cos_wr = Math.cos(wheels_angle_concave)
        squares = @wheelbase * @wheelbase + delta * delta
        c2 = squares - 2 * @wheelbase * delta * cos_wr
        c = Math.sqrt(c2)
        Math.acos((@wheelbase - delta * cos_wr) / c)
      end

      def active_lights
        state.lights_on ? @lights : []
      end

      def collision_pixels
        @core.collision_pixels(@pos_x, @pos_y, @rotation)
      end

      protected

      def set_default_values
        initialize_dimensions
        @img_path = nil
      end

      def compute_wheelbase
        @wheelbase = @wheels_rear - @wheels_front
        wheel_center = (@wheels_front + @wheels_rear) / 2
        @wheelbase_center = 1 - wheel_center.to_f / @width
        x_center = (width - (@wheels_front + @wheels_rear)) / 2
        @core.center_points(x_center, 0)
      end

      # Sets up stuff related to dimensions of the car
      def initialize_dimensions
        @width = 150
        @height = 50
        @wheels_front = 35
        @wheels_rear = 122
      end

      def wheels_angle_concave
        Math::PI - @wheels.rotation
      end
    end
  end
end
