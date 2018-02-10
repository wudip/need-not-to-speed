require 'view/painters/painter'
require 'view/ui_components/support/point'

module NeedNotToSpeed
  module View
    # Image of a car
    class CarImage < Painter
      IMAGE_DIR = 'lib/images/'.freeze
      IMAGE_EXTENSION = '.png'.freeze
      IMAGE_WHEELS_L_POSTFIX = '_wheels_l.png'.freeze
      IMAGE_WHEELS_R_POSTFIX = '_wheels_r.png'.freeze
      IMAGE_LIGHT_NAME = 'light.png'.freeze
      class << self
        attr_accessor :image_light
      end
      @image_light = nil

      def initialize(world, car)
        super(world)
        @car = car
        init_images
      end

      def init_images
        path_prefix = IMAGE_DIR + @car.img_path
        path = path_prefix + IMAGE_EXTENSION
        @image = Gosu::Image.new(path)
        init_wheel_images(path_prefix)
        init_light_image
      end

      def init_light_image
        return unless self.class.image_light.nil?
        img = Gosu::Image.new(IMAGE_DIR + IMAGE_LIGHT_NAME)
        self.class.image_light = img
      end

      def init_wheel_images(path_prefix)
        wheels_l_path = path_prefix + IMAGE_WHEELS_L_POSTFIX
        wheels_r_path = path_prefix + IMAGE_WHEELS_R_POSTFIX
        @image_wheels_l = Gosu::Image.new(wheels_l_path)
        @image_wheels_r = Gosu::Image.new(wheels_r_path)
        @image_wheels_r = Gosu::Image.new(wheels_r_path)
      end

      def draw
        @position = Point.new(@car.pos_x, @car.pos_y)
        rotation = @car.rotation * 180 / Math::PI
        draw_wheels(rotation)
        draw_lights
        draw_rot(@image, @position, 3, rotation, @car.wheelbase_center)
        draw_debug_points
      end

      def draw_lights
        @car.active_lights.each do |light|
          light_rotation = light.rotation * 180 / Math::PI
          position = Point.new(light.pos_x, light.pos_y)
          draw_rot(self.class.image_light, position, 3, light_rotation, 0.01)
        end
      end

      def draw_wheels(rotation)
        draw_parts(@image_wheels_l, rotation) if @car.state.turning_left
        draw_parts(@image_wheels_r, rotation) if @car.state.turning_right
      end

      def draw_parts(image, rotation)
        draw_rot(image, @position, 2, rotation, @car.wheelbase_center)
      end

      def draw_debug_points
        @car.collision_pixels.each do |pixel|
          draw_point(pixel[:x], pixel[:y], 4)
        end
      end
    end
  end
end
