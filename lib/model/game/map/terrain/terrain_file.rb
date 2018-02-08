require 'chunky_png'

module NeedNotToSpeed
  module Game
    # File encoding map's terrain
    class TerrainFile
      # Loads a terrain png file from specified path
      # @param path [String] path of the terrain file
      def initialize(path)
        @file = ChunkyPNG::Image.from_file(path)
      end

      # Gets pixel value of specified point
      # @param x [Integer] x coord of the specified point
      # @param y [Integer] y coord of the specified point
      # @return [Integer] pixel value in RBG format (65536 * R + 256 * G + B)
      def pixel(x, y)
        @file[x, y] / 256 # I don't need alpha
      end

      # @return [Integer] width of the file
      def width
        @file.dimension.width
      end

      # @return [Integer] height of the file
      def height
        @file.dimension.height
      end
    end
  end
end