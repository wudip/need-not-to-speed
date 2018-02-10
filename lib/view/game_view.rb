require 'view/painters/car_image'
require 'view/painters/object_image'
require 'view/painters/background'
require 'view/painters/crash_circle'
require 'view/ui_components/messages/game_end_message'
require 'view/ui_components/messages/game_won_message'

module NeedNotToSpeed
  module View
    # Class for displaying the actual game
    class GameView
      def initialize(game, objects, cars)
        @game = game
        @shadows = []
        fill_shadows(objects, cars)
        @offset_x = 1280 / 2
        @offset_y = 846 / 2
        @background = Background.new(self, game.level) unless game.nil?
        @modal_window = nil
      end

      def fill_shadows(objects, cars)
        fill_shadow_objects(objects)
        fill_shadow_cars(cars)
      end

      def fill_shadow_objects(objects)
        objects.each do |object|
          @shadows.push(ObjectImage.new(self, object))
        end
      end

      def fill_shadow_cars(cars)
        cars.each do |car|
          @shadows.push(CarImage.new(self, car))
        end
      end

      def things_to_draw
        [@background, @shadows]
      end

      def translation_x
        @offset_x - @game.translation_x
      end

      def translation_y
        @offset_y - @game.translation_y
      end

      def display_collision(collision_spot)
        x = translation_x + collision_spot[:x]
        y = translation_y + collision_spot[:y]
        @shadows.push(CrashCircle.new(x, y))
      end

      def find_button(x, y)
        return @modal_window.find_button(x, y) unless @modal_window.nil?
        nil
      end

      def display_victory
        @modal_window = GameWonMessage.new(@offset_x, @offset_y)
        @shadows.push(@modal_window)
      end

      def display_end
        @modal_window = GameEndMessage.new(@offset_x, @offset_y)
        @shadows.push(@modal_window)
      end
    end
  end
end
