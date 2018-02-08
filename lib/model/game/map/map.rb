require 'model/game/map/terrain/terrain'

module NeedNotToSpeed
  module Game
    # Class containing whole world including static and dynamic objects
    class Map
      # Sets area which player should reach
      attr_writer :final_area
      # Gets all objects placed on the map
      attr_reader :objects
      # Creates new map
      # @param level_name [String] name of the level (to load proper terrain file)
      def initialize(level_name)
        @width = 1000
        @height = 750
        @terrain = Terrain.new(level_name)
        @objects = []
        @stop_signs = []
        @final_area = nil
      end

      # Adds new object to the map
      # @param object [Object] object to put on the map
      def add(object)
        @objects.push(object)
      end

      # Adds new stop sign
      # @param object [StopSign] stop sign to put on the map
      def add_stop_sign(object)
        @stop_signs.push(object)
      end

      # @return [List] all active objects (objects that responds to update
      # method)
      def active_objects
        active = []
        @objects.each do |object|
          active.push(object) if object.respond_to? :update
        end
      end

      # Check whether there has been an collision between specified object and
      # map's objects or terrain
      # @param object [Object] object whose possible collision is inspected
      # @return [Hash, nil] nil in case or no collision or hash containing two
      # keys: x and y specifying x and y coords of the point where collision
      # occurred (or just first point discovered in case of multiple collision)
      def check_collision(object)
        spot = check_collision_terrain(object)
        return spot unless spot.nil?
        spot = check_collision_all_objects(object)
        return spot unless spot.nil?
        check_collision_stop_signs(object)
      end

      # Check whether there has been an collision between specified object and
      # an stop sign
      # @param object [Object] object whose possible collision is inspected
      # @return [Hash, nil] nil in case or no collision or hash containing two
      # keys: x and y specifying x and y coords of the point where collision
      # occurred (or just first point discovered in case of multiple collision)
      def check_collision_stop_signs(object)
        @stop_signs.each do |sign|
          collision = sign.collision(object)
          return collision unless collision.nil?
        end
        nil
      end

      # Check whether there has been an collision between specified object and
      # map's terrain
      # @param object [Object] object whose possible collision is inspected
      # @return [Hash, nil] nil in case or no collision or hash containing two
      # keys: x and y specifying x and y coords of the point where collision
      # occurred (or just first point discovered in case of multiple collision)
      def check_collision_terrain(object)
        object.get_pixels.each do |pixel|
          x = pixel[:x]
          y = pixel[:y]
          return { x: x, y: y } if @terrain.terrain_type(x, y) == :blocked
        end
        nil
      end

      # Check whether there has been an collision between specified object and
      # an map's static objects
      # @param ref [Object] object whose possible collision is inspected
      # @return [Hash, nil] nil in case or no collision or hash containing two
      # keys: x and y specifying x and y coords of the point where collision
      # occurred (or just first point discovered in case of multiple collision)
      def check_collision_all_objects(ref)
        @objects.each do |object|
          collision = check_collision_objects(ref, object)
          return collision unless collision.nil?
        end
        nil
      end

      # @return [Boolean] true if specified object reached final area, false if not
      def reached_end?(object)
        return false if @final_area.nil?
        @final_area.inside?(object)
      end

      private

      # Check collision between two specified objects
      # @param o0 [Object] first object
      # @param o1 [Object] second object
      # @return [Hash, nil] nil in case or no collision or hash containing two
      # keys: x and y specifying x and y coords of the point where collision
      # occurred (or just first point discovered in case of multiple collision)
      def check_collision_objects(o0, o1)
        o0.get_pixels.each do |p0|
          collision = check_collision_pixel(o1, p0[:x].to_i, p0[:y].to_i)
          return collision unless collision.nil?
        end
        nil
      end

      # Check collision between specified object and a point
      # @param object [Object] the object
      # @param x [Integer] x coord of the point
      # @param y [Integer] y coord of the point
      # @return [Hash, nil] nil in case or no collision or hash containing two
      # keys: x and y specifying x and y coords of the point where collision
      # occurred
      def check_collision_pixel(object, x, y)
        object.get_pixels.each do |pixel|
          x1 = pixel[:x].to_i
          y1 = pixel[:y].to_i
          return { x: x, y: y } if x1 == x && y1 == y
        end
        nil
      end
    end
  end
end