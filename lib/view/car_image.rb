module NeedNotToSpeed
  class CarImage
    def initialize(car)
      @car = car
    end

    def draw(window)
      Gosu::draw_rect(@car.x, @car.y, @car.width, @car.height, Gosu::Color::YELLOW)
    end
  end
end
