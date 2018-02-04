require 'model/game/map/terrain'
require 'model/game/map/objects/traffic_light/traffic_light'

module NeedNotToSpeed
  # Class containing whole world including static and dynamic objects
  class Map
    attr_writer :final_area
    attr_reader :objects
    def initialize(level_name)
      @width = 1000
      @height = 750
      @terrain = Terrain.new(level_name)
      @objects = []
      @stop_signs = []
      @final_area = nil
    end

    def add(object)
      @objects.push(object)
    end

    def add_stop_sign(object)
      @stop_signs.push(object)
    end

    def active_objects
      active = []
      @objects.each do |object|
        active.push(object) if object.respond_to? :update
      end
    end

    def check_collision(object)
      spot = check_collision_terrain(object)
      return spot unless spot.nil?
      spot = check_collision_all_objects(object)
      return spot unless spot.nil?
      check_collision_stop_signs(object)
    end

    def check_collision_stop_signs(object)
      @stop_signs.each do |sign|
        collision = sign.collision(object)
        return collision unless collision.nil?
      end
      nil
    end

    def check_collision_terrain(object)
      object.get_pixels.each do |pixel|
        x = pixel[:x]
        y = pixel[:y]
        return { x: x, y: y } if @terrain.terrain_type(x, y) == :blocked
      end
      nil
    end

    def check_collision_all_objects(ref)
      @objects.each do |object|
        collision = check_collision_objects(ref, object)
        return collision unless collision.nil?
      end
      nil
    end

    def check_collision_objects(o0, o1)
      o0.get_pixels.each do |p0|
        collision = check_collision_pixel(o1, p0[:x].to_i, p0[:y].to_i)
        return collision unless collision.nil?
      end
      nil
    end

    def check_collision_pixel(object, x, y)
      object.get_pixels.each do |pixel|
        x1 = pixel[:x].to_i
        y1 = pixel[:y].to_i
        return { x: x, y: y } if x1 == x && y1 == y
      end
      nil
    end

    def reached_end?(object)
      return false if @final_area.nil?
      @final_area.inside?(object)
    end
  end
end
