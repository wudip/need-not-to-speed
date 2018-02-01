module NeedNotToSpeed
  # Class controlling all menus, loaders and another things not related
  # to the actual game. It doesn't display them (there is whole view layer to do
  # so, this class just decides what to do and calls appropriate method to
  # display the controls)
  class ControlsModel
    def initialize(displayer, daddy)
      @displayer = displayer
      @daddy = daddy
      display_menu
    end

    def display_menu
      @mode = :menu
      @buttons = { start: proc { start_game }, end: proc { exit } }
      @displayer.display_menu([{ title: 'Start', name: 'start' },
                               { title: 'End', name: 'end' }])
      @displayer.handler = self
    end

    def display_loader
      @mode = :loader
      @displayer.display_loader(3, 5)
    end

    def click_button(name)
      action = @buttons[name.to_sym]
      action.call
    end

    def start_game
      @daddy.start_game
    end

    def quit_game
      @mode = :game_end
      @displayer.handler = self
      display_game_end
    end

    def exit
      @daddy.exit
    end

    def update
      display_game_end if @mode == :game_end
    end

    def display_game_end
      @displayer.display_game_end
    end

    def handle_key_down(key) end

    def handle_key_up(key) end

    def handle_mouse_down(key, x, y) end
  end
end
