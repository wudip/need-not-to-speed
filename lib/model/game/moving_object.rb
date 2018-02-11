module NeedNotToSpeed
  module Game
    # Some object moving on the map
    class MovingObject
      attr_reader :pos_x, :pos_y, :rotation

      def initialize(pos_x, pos_y, rotation)
        @pos_x = pos_x.to_f
        @pos_y = pos_y.to_f
        @rotation = rotation
        @acceleration = 0.05
        @rotation = -Math::PI / 2
        @speed_max = 0.05
        @slowing_coefficient = 0.5 * @acceleration
        @speed_reverse_min = -5
        @speed = 0
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

      def update_last_stop
        @last_stop = { x: @pos_x, y: @pos_y } if @speed.to_i.zero?
      end

      def update_position
        @pos_x += @speed * Math.cos(@rotation)
        @pos_y += @speed * Math.sin(@rotation)
      end

      def last_stop
        [@last_stop[:x], @last_stop[:y]]
      end
    end
  end
end
