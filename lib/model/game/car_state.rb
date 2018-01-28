module NeedNotToSpeed
  # State of a car - what keys are pressed
  class CarState
    attr_accessor :turning_left, :turning_right, :speeding_up, :slowing_down, :braking
    def initialize
      @turning_left = false
      @turining_right = false
      @speeding_up = false
      @slowing_down = false
      @braking = false
    end
  end
end
