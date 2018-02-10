module NeedNotToSpeed
  module Game
    # Traffic lights - object in map. When it's red it creates a line
    # with same collision behaviour as a wall
    class TrafficLight
      # How long does one color stay on the lights
      MAX_TIME = 200
      attr_reader :pos_x, :pos_y, :rotation
      # Creates new traffic lights
      # @param center_x [Integer] x position of traffic light's column center
      # @param center_y [Integer] y position of traffic light's column center
      # @param line_length [Integer] length of line next to the traffic lights
      # (end of it should match end of traffic lane). It's considered collision
      # when car crosses it and the lights are red.
      # @param rotation [Float] rotation of the traffic lights (in radians),
      # zero rotation means traffic lights pointing right
      def initialize(center_x, center_y, line_length, rotation)
        @pos_x = center_x
        @pos_y = center_y
        @rotation = rotation
        @mode = :red
        @time = 0
        init_line(line_length)
      end

      # Updates traffic light's state
      def update
        @time += 1
        return if @time < MAX_TIME
      end

      # Changes mode from red to green and vice versa
      def switch_mode
        @mode = @mode == :red ? :green : :red
      end

      # @return [String] image identifier of the object (differs when it' red
      # and when it's green)
      def img_path
        IMG_URL_PREFIX + mode_url
      end

      # @return [List] all points of the traffic lights that could collide with
      # another objects (it's collision when they are placed on the same point)
      def collision_pixels
        @mode == :red ? @line : []
      end

      private

      # First part of file identifier (the second one depends on current color)
      IMG_URL_PREFIX = 'traffic_light_'.freeze

      # Computes prefix of file identifier according to color on the lights
      def mode_url
        @mode == :red ? 'red' : 'green'
      end

      def init_line(length)
        @line = []
        if @rotation == 90 || @rotation == 270
          init_line_vertical(length)
        else
          init_line_horizontal(length)
        end
      end

      def init_line_vertical(length)
        x = @pos_x
        sign = @rotation == 270 ? 1 : -1
        length.times do
          @line.push(x: x, y: @pos_y)
          x += sign
        end
      end

      def init_line_horizontal(length)
        y = @pos_y
        sign = @rotation.zero? ? 1 : -1
        length.times do
          @line.push(x: @pos_x, y: y)
          y += sign
        end
      end
    end
  end
end
