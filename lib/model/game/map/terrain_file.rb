require 'chunky_png'

module NeedNotToSpeed
  # Loads map details from files
  class TerrainFile
    def initialize(path)
      @file = ChunkyPNG::Image.from_file(path)
    end

    def pixel(x, y)
      @file[x, y] / 256 # I don't need alpha
    end

    def width
      @file.dimension.width
    end

    def height
      @file.dimension.height
    end
  end
end
