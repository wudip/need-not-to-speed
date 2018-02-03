module NeedNotToSpeed
  # State of a car - what keys are pressed
  class CarState
    attr_accessor :turning_left, :turning_right, :speeding_up, :slowing_down,
                  :braking, :lights_on
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
