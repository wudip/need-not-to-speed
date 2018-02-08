module NeedNotToSpeed
  module Game
    # State of a car, describes user's actions to handle the car - speeding up
    # or slowing down, turning, braking or switching lights
    class CarState
      attr_accessor :turning_left, :turning_right, :speeding_up, :slowing_down,
                    :braking, :lights_on
      # Creates new car's state - all actions are considered as not performed
      # (eg. not speeding up)
      def initialize
        @turning_left = false
        @turning_right = false
        @speeding_up = false
        @slowing_down = false
        @braking = false
        @lights_on = false
      end
    end
  end
end