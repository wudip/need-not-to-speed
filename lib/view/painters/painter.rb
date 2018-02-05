module NeedNotToSpeed
  # An class that paints assigned object
  class Painter
    # Creates new painter object. It paints thing in a world 
    # from which this object takes trainslation coordinates.
    # @param world [Map] a world Painter's assigned object is placed in.
    def initialize(world)
      @world = world
    end

    # Draws an image
    # @param image [Gosu::Image] the image to draw
    # @param x [Integer] horizontal position of the center of the image (from left side of the map)
    # @param y [Integer] vertical position of the center of the image (from top of the map)
    # @param layer [Integer] z coordinate - the image covers all objects with lower layer
    def draw_img(image, x, y, layer)
      x += @world.translation_x
      y += @world.translation_y
      image.draw(x, y, layer)
    end

    # Draws an image with rotation
    # @param image the image to draw
    # @param x [Integer] horizontal position of the center of the image (from left side of the map)
    # @param y [Integer] vertical position of the center of the image (from top of the map)
    # @param layer [Integer] z coordinate - the image covers all objects with lower layer
    # @param rotation [Integer] rotation of the image, in degrees, 0 = no rotation
    # @param center_x [Float] horizontal center of rotation (in percent of the image, between 0 and 1)
    def draw_rot(image, x, y, layer, rotation, center_x = 0.5)
      x += @world.translation_x
      y += @world.translation_y
      image.draw_rot(x, y, layer, rotation, center_x)
    end

    # Draws a single white point
    # @param x [Integer] horizontal position of the center of the image (from left side of the map)
    # @param y [Integer] vertical position of the center of the image (from top of the map)
    # @param layer [Float] z coordinate - the image covers all objects with lower layer
    def draw_point(x, y, layer)
      x += @world.translation_x
      y += @world.translation_y
      Gosu.draw_rect(x, y, 2, 2, Gosu::Color::WHITE, layer)
    end
  end
end
