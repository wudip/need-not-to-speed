module NeedNotToSpeed
  # A car, either player's car or AI car
  class Car
    attr_reader :x, :y, :img_path
    def initialize(x, y, img_path, wheels_front, wheels_rear)
      @x = x
      @y = y
      @img_path = img_path
      @wheels_front = wheels_front
      @wheels_rear = wheels_rear
      @acceleration = 0.2
      @rotation = 0.2
      @speed_max = 10
      @turning_constant = 0.1
      @speed_reverse_min = -5
      @speed = 0
      @direction = 0
      @velocity_x = 0
      @velocity_y = 0
    end

    def speed_up
      @speed += @acceleration
      @speed = @speed_max if @speed > @speed_max
    end

    def slow_down
      @speed -= @acceleration
      @speed = @speed_max if @speed < @speed_reverse_min
    end

    def brake
      @speed -= @acceleration
      @speed = 0 if @speed < 0
    end

    def turn_left
      @rotation += @turning_constant
    end

    def turn_right
      @rotation -= @turning_constant
    end

    def refresh
    end
  end
end
