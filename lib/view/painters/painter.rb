module NeedNotToSpeed
  class Painter
    def initialize(world)
      @world = world
    end

    def draw_img(image, x, y, layer)
      x += @world.translation_x
      y += @world.translation_y
      image.draw(x, y, layer)
    end

    def draw_rot(image, x, y, layer, rotation, center_x)
      x += @world.translation_x
      y += @world.translation_y
      image.draw_rot(x, y, layer, rotation, center_x)
    end

    def draw_point(x, y, layer)
      x += @world.translation_x
      y += @world.translation_y
      Gosu.draw_rect(x, y, 2, 2, Gosu::Color::WHITE, layer)
    end
  end
end
