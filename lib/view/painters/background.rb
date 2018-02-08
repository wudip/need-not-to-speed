require 'view/painters/painter'

module NeedNotToSpeed
  module View
    # Background of a game (image of surface on which car moves)
    class Background < Painter
      PATH_TEMPLATE = 'lib/images/map/map_%{level}.png'.freeze
      def initialize(world, level)
        super(world)
        path = format(PATH_TEMPLATE, level: level)
        @image = Gosu::Image.new(path)
      end

      def draw
        draw_img(@image, 0, 0, 0)
      end
    end
  end
end