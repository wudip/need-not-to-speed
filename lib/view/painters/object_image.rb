require 'view/painters/painter'
require 'view/ui_components/support/point'

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
        position = Point.new(@object.pos_x, @object.pos_y)
        draw_rot(image, position, 2, @object.rotation)
        draw_debug_points
      end

      def draw_debug_points
        return unless NeedNotToSpeed::DEBUG_MODE
        @object.collision_pixels.each do |pixel|
          draw_point(pixel[:x], pixel[:y], 2)
        end
      end
    end
  end
end
