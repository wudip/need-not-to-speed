require 'view/painters/painter'

module NeedNotToSpeed
  class CarImage < Painter
    class << self
      attr_reader :image_dir, :image_extension, :image_wheels_l_postfix, :image_wheels_r_postfix
      attr_accessor :image_light
    end
    @image_dir = 'lib/images/'
    @image_extension = '.png'
    @image_wheels_l_postfix = '_wheels_l.png'
    @image_wheels_r_postfix = '_wheels_r.png'
    @image_light = nil

    def initialize(world, car)
      super(world)
      @car = car
      init_images
    end

    def init_images
      path_prefix = self.class.image_dir + @car.img_path
      path = path_prefix + self.class.image_extension
      @image = Gosu::Image.new(path)
      init_wheel_images(path_prefix)
      init_light_image
    end

    def init_light_image
      if self.class.image_light == nil
        img = Gosu::Image.new(self.class.image_dir + 'light.png')
        self.class.image_light = img
      end
    end

    def init_wheel_images(path_prefix)
      wheels_l_path = path_prefix + self.class.image_wheels_l_postfix
      wheels_r_path = path_prefix + self.class.image_wheels_r_postfix
      @image_wheels_l = Gosu::Image.new(wheels_l_path)
      @image_wheels_r = Gosu::Image.new(wheels_r_path)
      @image_wheels_r = Gosu::Image.new(wheels_r_path)
    end

    def draw(window)
      rotation = @car.rotation * 180 / Math::PI
      draw_wheels(rotation)
      draw_lights(rotation)
      draw_rot(@image, @car.x, @car.y, 3, rotation, @car.wheelbase_center)
    end

    def draw_lights(rotation)
      @car.active_lights.each do |light|
        light_rotation = light.rotation * 180 / Math::PI
        draw_rot(self.class.image_light, light.x, light.y, 3, light_rotation, 0.01)
      end
    end

    def draw_wheels(rotation)
      draw_parts(@image_wheels_l, rotation) if @car.state.turning_left
      draw_parts(@image_wheels_r, rotation) if @car.state.turning_right
    end

    def draw_parts(image, rotation)
      draw_rot(image, @car.x, @car.y, 2, rotation, @car.wheelbase_center)
    end
  end
end
