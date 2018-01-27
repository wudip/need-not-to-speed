module NeedNotToSpeed
  # Class controlling all menus, loaders and another things not related
  # to the actual game. It doesn't display them (there is whole view layer to do
  # so, this class just decides what to do and calls appropriate method to
  # display the controls)
  class ControlsModel
    def initialize(displayer)
      @displayer = displayer
      @displayer.handler = self
      display_menu
    end

    def display_menu
      @displayer.display_menu([{ title: 'Start', name: 'start' },
                               { title: 'End', name: 'end' }])
      @buttons = { start: proc { start_game }, end: proc { exit } }
    end

    def click_button(name)
      action = @buttons[name.to_sym]
      action.call
    end

    def start_game
    end

    def exit
      @displayer.close
    end
  end
end
