require 'view/ui_components/buttons/text_button'
require 'view/ui_components/controls_container'
require 'view/ui_components/image_component'
require 'view/ui_components/point'
require 'view/ui_components/dimensions'

module NeedNotToSpeed
  # Shows message about end of the game
  class GameEndMessage
    IMG_FILE_NAME = 'game-over'.freeze
    WIDTH = 300
    HEIGHT = 300
    IMAGE_Y_OFFSET = 300
    RESTART_BTN_TITLE = 'Restart'.freeze
    @restart_btn_name = 'restart'
    class << self; attr_reader :restart_btn_name end

    def initialize(center_x, center_y)
      button = init_button(center_x, center_y)
      image = init_image(center_x, center_y)
      container_pos = Point.new(center_x - WIDTH / 2, center_y - HEIGHT / 2)
      container_dim = Dimensions.new(WIDTH, HEIGHT)
      @container = ControlsContainer.new(container_pos, container_dim)
      @container.add(button)
      @container.add(image)
    end

    def draw
      @container.draw
    end

    def find_button(x, y)
      @container.find_button(x, y)
    end

    private

    def init_button(center_x, center_y)
      name = self.class.restart_btn_name
      size = Dimensions.new(200, 50)
      position = Point.new(center_x, center_y)
      TextButton.new(RESTART_BTN_TITLE, name, position, size)
    end

    def init_image(center_x, center_y)
      img_y = center_y - IMAGE_Y_OFFSET
      ImageComponent.new(IMG_FILE_NAME, center_x, img_y)
    end

  end
end
