require 'json'

require 'model/game/map/terrain'
require 'model/game/map/objects/traffic_light/traffic_light'
require 'model/game/map/final_area'

module NeedNotToSpeed
  # Translates string (hash) definitions to map objects
  class ObjectParser
    LEVEL_DIR = 'resources/levels/'.freeze
    FILE_EXTENSION = '.json'.freeze
    class << self
      def parse(properties)
        case properties['type']
        when 'traffic_lights'
          parse_traffic_lights(properties)
        else
          puts 'Error parsing level fie'
          nil
        end
      end

      def parse_traffic_lights(properties)
        x = properties['x']
        y = properties['y']
        rotation = properties['rotation']
        line = properties['line_length']
        TrafficLight.new(x, y, line, rotation)
      end

      def parse_final_area(properties)
        x = properties['x']
        y = properties['y']
        width = properties['width']
        height = properties['height']
        FinalArea.new(x, y, width, height)
      end
    end
  end
end