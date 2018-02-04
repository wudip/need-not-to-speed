require 'json'

require 'model/game/map'
require 'model/game/level/object_parser'
require 'model/game/map/stop_sign'

module NeedNotToSpeed
  # Contains all items (including map) related to a game level
  class Level
    LEVEL_DIR = 'resources/levels/'.freeze
    FILE_EXTENSION = '.json'.freeze
    class << self
      def parse_level_file(file_name)
        path = LEVEL_DIR + file_name + FILE_EXTENSION
        file = File.read(path)
        JSON.parse(file)
      end
    end
    attr_reader :map
    def initialize(file_name)
      @hash = self.class.parse_level_file(file_name)
      load_map(file_name)
    end

    # @return [Integer, Integer] starting position of the car
    def start_position
      position = @hash['start_position']
      x = position['x'].to_i
      y = position['y'].to_i
      [x, y]
    end

    private

    def load_map(level_name)
      @map = Map.new(level_name)
      @hash['objects'].each do |object_hash|
        object = ObjectParser.parse(object_hash)
        @map.add(object) unless object.is_a? StopSign
        @map.add_stop_sign(object) if object.is_a? StopSign
        @map.final_area = final_area
      end
    end

    # Private, use Map's equivalent instead
    def final_area
      properties = @hash['final_area']
      ObjectParser.parse_final_area(properties)
    end
  end
end
