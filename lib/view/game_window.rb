require 'gosu'

module NeedNotToSpeed
  # A window that can be displayed by `show` method and display some stuff
  # on user's screen
  class GameWindow < Gosu::Window
    def initialize
      super(1280, 846, false)
      self.caption = 'Need Not To Speed'
    end
  end
end
