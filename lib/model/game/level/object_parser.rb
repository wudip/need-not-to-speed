require 'json'

require 'model/game/map/terrain/terrain'
require 'model/game/map/objects/stop_sign'
require 'model/game/map/objects/final_area'
require 'model/game/map/objects/traffic_light'

module NeedNotToSpeed
  module Game
    # Translates string (hash) definitions to map objects
    class ObjectParser
      LEVEL_DIR = 'resources/levels/'.freeze
      FILE_EXTENSION = '.json'.freeze
      class << self
        def parse(properties)
          case properties['type']
          when 'traffic_lights'
            parse_traffic_lights(properties)
          when 'stop'
            parse_stop_sign(properties)
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

        def parse_stop_sign(properties)
          start_x = properties['start_x']
          start_y = properties['start_y']
          end_x = properties['end_x']
          end_y = properties['end_y']
          rotation = (properties['rotation'] * Math::PI) / 180
          StopSign.new(start_x, start_y, end_x, end_y, rotation)
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
end