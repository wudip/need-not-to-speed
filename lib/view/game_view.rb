require 'view/painters/car_image'
require 'view/painters/background'

module NeedNotToSpeed
  class GameView
    def initialize(game, objects, cars)
      @game = game
      @shadows = []
      fill_shadows(objects, cars)
      @offset_x = 1280 / 2
      @offset_y = 846 / 2
      @background = Background.new(self)
    end

    def fill_shadows(objects, cars)
      fill_shadow_cars(cars)
    end

    def fill_shadow_cars(cars)
      cars.each do |car|
        @shadows.push(CarImage.new(self, car))
      end
    end

    def things_to_draw
      [@background, @shadows]
    end

    def translation_x
      @offset_x - @game.translation_x
    end

    def translation_y
      @offset_y - @game.translation_y
    end
  end
end
