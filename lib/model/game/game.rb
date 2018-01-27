module NeedNotToSpeed
  # Class controlling whole game. It computes every object's position, it's
  # position, stores score and so on. It also sends data to display to the
  # view layer.
  class Game
    # @param [ViewLayer] displayer object that displays all game data on
    # the screen
    def initialize(displayer)
      @displayer = displayer
      @map = Map.new
      @active_objects = []
      @car = PlayerCar.new
    end
  end
end
