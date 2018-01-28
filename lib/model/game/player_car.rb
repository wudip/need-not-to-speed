require 'model/game/car'

module NeedNotToSpeed
  # Class representing player's car
  class PlayerCar < Car
    def initialize
      super(0, 0, nil, 50, 30)
    end
  end
end
