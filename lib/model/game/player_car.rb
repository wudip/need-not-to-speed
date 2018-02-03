require 'model/game/cars/t603'
require 'model/game/cars/saxo'

module NeedNotToSpeed
  # Class representing player's car
  class PlayerCar < Saxo
    def initialize(x, y)
      super(x, y)
    end
  end
end
