require 'view/painters/painter'

module NeedNotToSpeed
  class Background < Painter
    def initialize(world)
      super(world)
      path = 'lib/images/map/map_0.png'
      @image = Gosu::Image.new(path)
    end

    def draw(window)
      draw_img(@image, 0, 0, 0)
    end
  end
end
