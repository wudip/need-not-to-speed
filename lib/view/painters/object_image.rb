require 'view/painters/painter'

module NeedNotToSpeed
  module View
    # Image of an object
    class ObjectImage < Painter
      IMAGE_DIR = 'lib/images/'.freeze
      IMAGE_EXTENSION = '.png'.freeze

      def initialize(world, object)
        super(world)
        @object = object
      end

      def draw
        path = IMAGE_DIR + @object.img_path + IMAGE_EXTENSION
        image = Gosu::Image.new(path)
        draw_rot(image, @object.pos_x, @object.pos_y, 2, @object.rotation)

        @object.get_pixels.each do |pixel|
          draw_point(pixel[:x], pixel[:y], 2)
        end
      end
    end
  end
end
