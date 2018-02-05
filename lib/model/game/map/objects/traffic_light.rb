module NeedNotToSpeed
  module Game
    # Traffic light - object in map. When it's red it creates a line
    # with same collision behaviour as a wall
    class TrafficLight
      MAX_TIME = 200
      IMG_URL_PREFIX = 'traffic_light_'.freeze
      attr_reader :pos_x, :pos_y, :rotation

      def initialize(center_x, center_y, line_length, rotation)
        @pos_x = center_x
        @pos_y = center_y
        @rotation = rotation
        @mode = :red
        @time = 0
        init_line(line_length)
      end

      def update
        @time += 1
        if @time >= MAX_TIME
          @time = 0
          switch_mode
        end
      end

      def switch_mode
        @mode = @mode == :red ? :green : :red
      end

      def img_path
        IMG_URL_PREFIX + mode_url
      end

      def get_pixels
        @mode == :red ? @line : []
      end

      private

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
        sign = @rotation == 0 ? 1 : -1
        length.times do
          @line.push(x: @pos_x, y: y)
          y += sign
        end
      end
    end
  end
end