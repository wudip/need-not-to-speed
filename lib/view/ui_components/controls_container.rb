module NeedNotToSpeed
  module View
    # A container that contains another objects (eg. buttons) in it. It's
    # a rectangle that could be transparent or have some background colour.
    class ControlsContainer
      attr_accessor :color
      attr_reader :name
      def initialize(position, size, color = nil)
        @pos_x = position.pos_x
        @pos_y = position.pos_y
        @width = size.width
        @height = size.height
        @children = []
        @color = color
      end

      def add(child)
        @children.push(child)
      end

      def draw
        color_nil = @color.nil?
        Gosu.draw_rect(@pos_x, @pos_y, @width, @height, @color) unless color_nil
        @children.each(&:draw)
      end

      def inside_button?(x, y)
        x1 = @pos_x
        y1 = @pos_y
        x2 = x1 + @width
        y2 = y1 + @height
        x >= x1 && x <= x2 && y >= y1 && y <= y2
      end

      def find_button(x, y)
        @children.each do |child|
          is_btn = child.respond_to?(:inside_button?)
          return child.name if is_btn && child.inside_button?(x, y)
          is_container = child.respond_to?(:find_button)
          found_button = is_container ? child.find_button(x, y) : nil
          return found_button unless found_button.nil?
        end
        nil
      end
    end
  end
end
