require 'chunky_png'
require 'model/game/map/terrain/terrain_file'

module NeedNotToSpeed
  module Game
    # Surface on a map where car can go/can't go
    class Terrain
      # Color of the terrain file encoding blocked places (eg. buildings)
      COLOR_BLOCKED = 255 * 256 * 256
      # Color of the terrain file encoding road
      COLOR_ROAD = 0
      # Color of the terrain file encoding grass (currently same behaviour as
      # road)
      COLOR_GRASS = 255 * 256
      # Template of path of file encoding the terrain (actual path depends on
      # level number)
      TERRAIN_FILE_PATH = 'lib/images/map/map_%<level>s_terrain.png'.freeze
      def initialize(level)
        file_path = format(TERRAIN_FILE_PATH, level: level)
        @file = TerrainFile.new(file_path)
      end

      # @return [Integer] width of the whole defined terrain (in px)
      def width
        @file.width
      end

      # @return [Integer] height of the whole defined terrain (in px)
      def height
        @file.height
      end

      # Gets type of the terrain on the specified point
      # @param x [Integer] x coord of the specified point
      # @param y [Integer] y coord of the specified point
      # @return [Symbol] type of the terrain
      def terrain_type(x, y)
        return :blocked if x < 0 || y < 0 || x >= width || y >= height
        terrain_type_no_check(x.to_i, y.to_i)
      end

      # Gets type of the terrain on the specified point without any checking
      # for going beyond terrain boundaries
      # @param x [Integer] x coord of the specified point
      # @param y [Integer] y coord of the specified point
      # @return [Symbol] type of the terrain
      def terrain_type_no_check(x, y)
        case @file.pixel(x, y)
        when COLOR_ROAD
          :road
        when COLOR_BLOCKED
          :blocked
        when COLOR_GRASS
          :grass
        else
          :blocked
        end
      end
    end
  end
end
