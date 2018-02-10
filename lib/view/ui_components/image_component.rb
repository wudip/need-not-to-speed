module NeedNotToSpeed
  module View
    # An UI component containing an image that could be displayed on the screen
    class ImageComponent
      IMG_DIR = 'lib/images/'.freeze
      FILE_EXTENSION = '.png'.freeze
      def initialize(file_name, center_x, center_y)
        @pos_x = center_x
        @pos_y = center_y
        path = IMG_DIR + file_name + FILE_EXTENSION
        @image = Gosu::Image.new(path)
      end

      def draw
        @image.draw(@pos_x, @pos_y, 4)
      end
    end
  end
end
