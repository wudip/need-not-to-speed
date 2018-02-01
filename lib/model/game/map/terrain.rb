require 'chunky_png'
require 'model/game/map/terrain_file'

module NeedNotToSpeed
  # Loads map details from files
  class Terrain
    @color_blocked = 255 * 256 * 256
    @color_road = 0
    @color_grass = 255 * 256
    @terrain_file_path = 'lib/images/map/map_%{level}_terrain.png'
    class << self
      attr_reader :terrain_file_path, :color_road, :color_grass, :color_blocked
    end
    def initialize(level)
      file_path = format(self.class.terrain_file_path, level: level)
      puts file_path
      @file = TerrainFile.new(file_path)
    end

    def width
      @file.width
    end

    def height
      @file.height
    end

    def terrain_type(x, y)
      return :blocked if x < 0 || y < 0 || x >= width || y >= height
      terrain_type_no_check(x.to_i, y.to_i)
    end

    def terrain_type_no_check(x, y)
      case @file.pixel(x, y)
      when self.class.color_road
        :road
      when self.class.color_blocked
        :blocked
      when self.class.color_grass
        :grass
      else
        :blocked
      end
    end
  end
end
