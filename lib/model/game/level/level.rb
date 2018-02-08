require 'json'

require 'model/game/map/map'
require 'model/game/level/object_parser'
require 'model/game/map/objects/stop_sign'

module NeedNotToSpeed
  module Game
    # Contains all items (including map) related to a game level
    class Level
      # Directory containing data with data files that describe game levels
      LEVEL_DIR = 'resources/levels/'.freeze
      # Extension of level files
      FILE_EXTENSION = '.json'.freeze
      attr_reader :map
      # Creates new level
      # @param file_name [String] unique identifier of level (also name of
      # level file without extension)
      def initialize(file_name)
        @hash = parse_level_file(file_name)
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

      # Loads JSON data from level file and stores them in hash object
      # @param file_name [String] name of level JSON file
      # @return [Hash] hash map with data and scructure same as level's
      # JSON file
      def parse_level_file(file_name)
        path = LEVEL_DIR + file_name + FILE_EXTENSION
        file = File.read(path)
        JSON.parse(file)
      end

      # Loads map and places all objects there
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
end