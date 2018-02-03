require 'model/game/map/terrain'

module NeedNotToSpeed
  # Class containing whole world including static and dynamic objects
  class Map
    attr_reader :objects
    def initialize
      @width = 1000
      @height = 750
      puts 'init terrain'
      @terrain = Terrain.new(0)
      @objects = []
    end

    def check_collision(object)
      spot = check_collision_terrain(object)
      return spot unless spot.nil?
      check_collision_objects(object)
    end

    def check_collision_objects(object)
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

  end
end
