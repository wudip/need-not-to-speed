require 'view/ui_components/buttons/text_button'

module NeedNotToSpeed
  module View
    # A button with a text
    class RadioTextButton < TextButton
      DEFAULT_ENABLED_BACKGROUND = Gosu::Color.argb(0xff_006f58)
      DEFAULT_DISABLED_BACKGROUND = Gosu::Color.argb(0xff_1a352f)
      attr_reader :radio_group
      def initialize(title, name, position, size, radio_group)
        super(title, name, position, size)
        @radio_group = radio_group
        unselect
      end

      def select
        @color = DEFAULT_ENABLED_BACKGROUND
      end

      def unselect
        @color = DEFAULT_DISABLED_BACKGROUND
      end
    end
  end
end
