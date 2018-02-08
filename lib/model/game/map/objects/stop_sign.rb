require 'model/game/crashable'

module NeedNotToSpeed
  module Game
    # Stop sign - object in map. Player has to stop at least
    # square root of "#{SQR_STOPPING_AREA_LENGTH}" from it.
    class StopSign
      # Length of area before the stop sign where car has to stop (squared to
      # make computation easier)
      SQR_STOPPING_AREA_LENGTH = 10_000
      # Length from stop sign's line where car is considered 'crossing the line'
      # (squared to make computation easier)
      SQR_MIN_DIST_FROM_LINE = 2500
      attr_reader :pos_x, :pos_y, :rotation
      # Creates new stop sign. The sign is encoded by two points and an angle.
      # If car is crossing the line between two specified point in the
      # direction opposite to car's movement direction and if it didn't stop
      # in close area before the sign then it's considered as collision
      # @param start_x [Integer] x coordinate of the first point of the line
      # @param start_y [Integer] y coordinate of the first point of the line
      # @param end_x [Integer] x coordinate of the second point of the line
      # @param end_y [Integer] y coordinate of the second point of the line
      # @param rotation [Float] facing of the sign (in radians), it should be
      # opposite of expected car's direction
      def initialize(start_x, start_y, end_x, end_y, rotation)
        @center_x = (start_x + end_x) / 2
        @center_y = (start_y + end_y) / 2
        @rotation = rotation
        init_line(start_x, start_y, end_x, end_y)
      end

      # Updates the stop sign (it's immutable so the method remains blank)
      def update; end

      # Checks for collision with specified object
      # @param object [Object] and object (probably car) to compute collision
      # with
      def collision(object)
        if near?(object) && passing_right_direction(object) &&
           didnt_stop(object)
          x = object.pos_x.to_i
          y = object.pos_y.to_i
          @line.each do |point|
            dist = sql_euclidean_distance_points(x, y, point[:x], point[:y])
            return { x: x, y: y } if dist < SQR_MIN_DIST_FROM_LINE
          end
        end
        nil
      end

      # Square euclidean distance between specified points and center of this
      # stop sign's line
      # @param x [Integer] horizontal position of specified point
      # @param y [Integer] vertical position of specified point
      def sqr_euclidean_distance(x, y)
        sql_euclidean_distance_points(x, y, @center_x, @center_y)
      end

      private

      def init_line(start_x, start_y, end_x, end_y)
        @line = []
        repeats, step_x, step_y = get_step(start_x, start_y, end_x, end_y)
        x = start_x
        y = start_y
        repeats.times do
          @line.push(x: x.to_i, y: y.to_i)
          x += step_x
          y += step_y
        end
      end

      def get_step(start_x, start_y, end_x, end_y)
        diff_x = (start_x - end_x).abs
        diff_y = (start_y - end_y).abs
        repeats = [diff_x, diff_y].max
        step_x = (diff_x.to_f / repeats).to_i
        step_y = (diff_x.to_f / repeats).to_i
        [repeats, step_x, step_y]
      end

      def near?(object)
        dist = sqr_euclidean_distance(object.pos_x, object.pos_y)
        dist < SQR_STOPPING_AREA_LENGTH
      end

      # @return [Boolean] true if object is passing the stop sign's direction,
      # false if not
      def passing_right_direction(object)
        rotation = object.rotation
        rotation += Math::PI if object.speed < 0
        min_boundary = @rotation - Math::PI / 2
        max_boundary = @rotation + Math::PI / 2
        angle_in_boundary?(rotation, min_boundary, max_boundary)
      end

      def didnt_stop(object)
        x, y = object.last_stop
        dist = sqr_euclidean_distance(x, y)
        dist > SQR_STOPPING_AREA_LENGTH
      end

      def normalize_angle(angle)
        angle -= Math::PI while angle >= 2 * Math::PI
        angle += Math::PI while angle < 0
        angle
      end

      def angle_in_boundary?(rotation, min_boundary, max_boundary)
        rotation -= 2 * Math::PI while rotation > 2 * Math::PI
        min_boundary -= 2 * Math::PI while min_boundary > rotation
        max_boundary -= 2 * Math::PI while max_boundary >= min_boundary
        max_boundary += 2 * Math::PI
        max_boundary >= rotation
      end

      def sql_euclidean_distance_points(x1, y1, x2, y2)
        dist_x = x1 - x2
        dist_y = y1 - y2
        dist_x * dist_x + dist_y * dist_y
      end
    end
  end
end
