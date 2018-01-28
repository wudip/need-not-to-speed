require 'view/car_image'

module NeedNotToSpeed
  class GameView
    def initialize(objects, cars)
      @shadows = []
      fill_shadows(objects, cars)
    end

    def fill_shadows(objects, cars)
      fill_shadow_cars(cars)
    end

    def fill_shadow_cars(cars)
      cars.each do |car|
        @shadows.push(CarImage.new(car))
      end
    end

    def things_to_draw
      @shadows
    end
  end
end
