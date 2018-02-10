module NeedNotToSpeed
  module Game
    # A thing that could collide with another things
    class Crashable
      # Creates new crashable object
      # @param points [List] list of points that defines the object. It's
      # considered collision if another object is placed on the same spot as
      # one of the points (each point has to be encoded as array where x coord
      # is first item and second coord is second item)
      def initialize(points)
        self.points = points
        @radius = 0
        center_x, center_y = compute_center
        center_points(center_x, center_y)
        compute_radius
      end

      # Sets list of points defining this object
      # @param points [List] list of the points (each point has to be encoded
      # as array where x coord is first item and second coord is second item)
      def points=(points)
        @points = []
        points.each do |point|
          @points.push(x: point[0], y: point[1])
        end
      end

      def center_points(x_center, y_center)
        @points.each do |point|
          point[:x] = point[:x] - x_center
          point[:y] = point[:y] - y_center
        end
      end

      def compute_radius
        @points.each do |point|
          dist = point[:x] * point[:x] + point[:y] * point[:y]
          @radius = dist if dist > @radius
        end
        @radius
      end

      def collision_pixels(translation_x, translation_y, rotation)
        new_points = []
        @points.each do |point|
          x = rotate_x(rotation, point[:x], point[:y])
          y = rotate_y(rotation, point[:x], point[:y])
          x += translation_x
          y += translation_y
          new_points.push(x: x, y: y)
        end
        new_points
      end

      def rotate_x(angle, x, y)
        base = x * Math.cos(angle)
        base + y * Math.sin(angle)
      end

      def rotate_y(angle, x, y)
        base = x * Math.sin(angle)
        base - y * Math.cos(angle)
      end

      private

      # Computes center of the object according to the list of points
      # @return [Array<Integer>] x and y coords of the center
      def compute_center
        x_center = center_value(@points, :x)
        y_center = center_value(@points, :y)
        [x_center, y_center]
      end

      def center_value(points, key)
        min = 9999
        max = -9999
        points.each do |point|
          min = point[key] if point[key] < min
          max = point[key] if point[key] > max
        end
        (min + max) / 2
      end
    end
  end
end
