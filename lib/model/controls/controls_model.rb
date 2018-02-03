module NeedNotToSpeed
  # Class controlling all menus, loaders and another things not related
  # to the actual game. It doesn't display them (there is whole view layer to do
  # so, this class just decides what to do and calls appropriate method to
  # display the controls)
  class ControlsModel
    NUMBER_OF_LEVELS = 1
    def initialize(viewer, daddy)
      @viewer = viewer
      @daddy = daddy
      display_menu
    end

    def display_menu
      @mode = :menu
      @buttons = { start: proc { start_game },
                   end: proc { exit },
                   restart: proc { start_game },
                   next_level: proc { next_level } }
      @viewer.display_menu([{ title: 'Start', name: 'start' },
                            { title: 'End', name: 'end' }])
      @viewer.handler = self
    end

    def display_loader
      @mode = :loader
      @viewer.display_loader
    end

    def click_button(name)
      action = @buttons[name.to_sym]
      action.call
    end

    def start_game
      @daddy.start_game
    end

    def win_game
      @mode = :game_won
      @viewer.handler = self
      display_victory
    end

    def quit_game
      @mode = :game_end
      @viewer.handler = self
      display_game_end
    end

    def next_level
      if @daddy.current_level + 1 >= NUMBER_OF_LEVELS
        display_menu
        @viewer.display_game_completed_message
      else
        @daddy.current_level += 1
        @daddy.start_game
      end
    end

    def exit
      @daddy.exit
    end

    def update
      display_victory if @mode == :game_won
      display_game_end if @mode == :game_end
    end

    def display_victory
      @viewer.display_victory
    end

    def display_game_end
      @viewer.display_game_end
    end

    def handle_key_down(_key) end

    def handle_key_up(_key) end

    def handle_mouse_down(_key, _x, _y) end
  end
end
