module NeedNotToSpeed
  # Class controlling all menus, loaders and another things not related
  # to the actual game. It doesn't display them (there is whole view layer to do
  # so, this class just decides what to do and calls appropriate method to
  # display the controls)
  class ControlsModel
    # Number of all levels in the game
    NUMBER_OF_LEVELS = 1

    # Creates new controls model
    # @param viewer [View::Viewer] object handling viewing all menus
    # @param daddy [NeedNotToSpeed] object handling calls like game start and
    # program end
    def initialize(viewer, daddy)
      @viewer = viewer
      @daddy = daddy
      display_menu
    end

    # Displays menu on the screen
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

    # Displays loading screen
    def display_loader
      @mode = :loader
      @viewer.display_loader
    end

    # Handles click on specified buton
    # @param name [String] name of button user clicked on
    def click_button(name)
      action = @buttons[name.to_sym]
      action.call
    end

    # Starts new game
    def start_game
      @daddy.start_game
    end

    # Takes control over viewer object and displays game victory message
    def win_game
      @mode = :game_won
      @viewer.handler = self
      display_victory
    end

    # Quits ongoing game and displays info about it
    def quit_game
      @mode = :game_end
      @viewer.handler = self
      display_game_end
    end

    # Increases level number and starts new game
    def next_level
      if @daddy.current_level + 1 >= NUMBER_OF_LEVELS
        display_menu
        @viewer.display_game_completed_message
      else
        @daddy.current_level += 1
        @daddy.start_game
      end
    end

    # Quits the whole program
    def exit
      @daddy.exit
    end

    # Re-computes controls to display
    def update
      display_victory if @mode == :game_won
      display_game_end if @mode == :game_end
    end

    # Displays message about victory
    def display_victory
      @viewer.display_victory
    end

    # Displays message about game end
    def display_game_end
      @viewer.display_game_end
    end

    # Handles key down event
    # @param _key [Integer] Gosu's encoding of the key pressed
    def handle_key_down(_key) end

    # Handles key up event
    # @param _key [Integer] Gosu's encoding of the key pressed
    def handle_key_up(_key) end

    # Handles mouse down event
    # @param _key [Integer] Gosu's encoding of the key pressed
    # @param _x [Integer] x position of mouse
    # @param _y [Integer] y position of mouse
    def handle_mouse_down(_key, _x, _y) end
  end
end
