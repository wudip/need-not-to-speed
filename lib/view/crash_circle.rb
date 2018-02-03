require 'gosu'
require 'view/crash_circle'

module NeedNotToSpeed
  # Represent circle appearing on place of car's accident
  class CrashCircle
    @rotation_step = 3
    @img_0_path = 'lib/images/crash_0.png'
    @img_1_path = 'lib/images/crash_0.png'
    class << self
      attr_reader :rotation_step, :img_0_path, :img_1_path
    end

    def initialize(x, y)
      @pos_x = x
      @pos_y = y
      @rotation = 0
      @image0 = Gosu::Image.new(self.class.img_0_path)
      @image1 = Gosu::Image.new(self.class.img_1_path)
    end

    def draw
      update_rotation
      @image0.draw_rot(@pos_x, @pos_y, 4, @rotation)
      @image1.draw_rot(@pos_x, @pos_y, 4, 360 - @rotation)
    end

    def update_rotation
      @rotation += self.class.rotation_step
      @rotation -= 360 while @rotation > 360
    end
  end
end
