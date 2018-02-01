require 'model/game/cars/t603'
require 'model/game/cars/saxo'

module NeedNotToSpeed
  # Class representing player's car
  class PlayerCar < Saxo
    def initialize
      super(1164, 1092)
    end
  end
end
