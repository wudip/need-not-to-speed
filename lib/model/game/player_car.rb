require 'model/game/cars/t603'

module NeedNotToSpeed
  # Class representing player's car
  class PlayerCar < T603
    def initialize
      super(80, 100)
    end
  end
end
