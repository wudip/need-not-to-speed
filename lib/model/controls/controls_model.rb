module NeedNotToSpeed
  # Class controlling all menus, loaders and another things not related
  # to the actual game. It doesn't display them (there is whole view layer to do
  # so, this class just decides what to do and calls appropriate method to
  # display the controls)
  class ControlsModel
    def initialize(viewer, daddy)
      @viewer = viewer
      @daddy = daddy
      display_menu
    end

    def display_menu
      @mode = :menu
      @buttons = { start: proc { start_game }, end: proc { exit } }
      @viewer.display_menu([{ title: 'Start', name: 'start' },
                            { title: 'End', name: 'end' }])
      @viewer.handler = self
    end

    def display_loader
      @mode = :loader
      @viewer.display_loader(3, 5)
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
      @viewer.handler = self
      display_game_end
    end

    def exit
      @daddy.exit
    end

    def update
      display_game_end if @mode == :game_end
    end

    def display_game_end
      @viewer.display_game_end
    end

    def handle_key_down(_key) end

    def handle_key_up(_key) end

    def handle_mouse_down(_key, _x, _y) end
  end
end
