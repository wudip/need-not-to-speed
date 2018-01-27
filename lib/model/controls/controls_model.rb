module NeedNotToSpeed
  # Class controlling all menus, loaders and another things not related
  # to the actual game. It doesn't display them (there is whole view layer to do
  # so, this class just decides what to do and calls appropriate method to
  # display the controls)
  class ControlsModel
    def initialize(displayer)
      @displayer = displayer
      display_menu
    end

    def display_menu
      @displayer.display_menu
    end
  end
end
