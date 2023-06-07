class Ball
    HEIGHT = 25
  
    attr_reader :shape, :x_velocity, :y_velocity,:x
  
    def initialize(speed)
      @x = 320
      @y = 400
      @speed = speed
      @y_velocity = [-speed, speed].sample
      @x_velocity = [-speed, speed].sample
    end
  
    def move
      if hit_bottom? || hit_top?
        PONG_SOUND.play
        @y_velocity = -@y_velocity
      end
  
      @x = @x + @x_velocity
      @y = @y + @y_velocity
    end
  
    def draw
      @shape = Square.new(x: @x, y: @y, size: HEIGHT, color: 'yellow')
    end
  
    def bounce_off(paddle)
      if @last_hit_side != paddle.side
        position = ((@shape.y1 - paddle.y1) / Paddle::HEIGHT.to_f)
        angle = position.clamp(0.2, 0.8) * Math::PI
  
        if paddle.side == :left
          @x_velocity = Math.sin(angle) * @speed
          @y_velocity = -Math.cos(angle) * @speed
        else
          @x_velocity = -Math.sin(angle) * @speed
          @y_velocity = -Math.cos(angle) * @speed
        end
  
        @last_hit_side = paddle.side
      end
    end
  
    def y_middle
      @y + (HEIGHT / 2)
    end
  
    def x_middle
      @x + (HEIGHT / 2)
    end
  
    def out_of_bounds?
      @x <= 0 || @shape.x2 >= Window.width
    end  
  
    private
  
  
    def hit_bottom?
      @y + HEIGHT >= Window.height
    end
  
    def hit_top?
      @y <= 0
    end
end

class BallTrajectory
    def initialize(ball)
      @ball = ball
    end
  
    def draw
      next_coordinates = NextCoordinates.new(@ball.x_middle, @ball.y_middle, @ball.x_velocity, @ball.y_velocity)
      line = Line.new(x1: @ball.x_middle, y1: @ball.y_middle, x2: next_coordinates.x, y2: next_coordinates.y, color: 'red', opacity: 0)
      if next_coordinates.hit_top_or_bottom?
        final_coordinates = NextCoordinates.new(next_coordinates.x, next_coordinates.y, @ball.x_velocity, -@ball.y_velocity)
        Line.new(x1: next_coordinates.x, y1: next_coordinates.y, x2: final_coordinates.x, y2: final_coordinates.y, color: 'red', opacity: 0)
      else
        line
      end
    end
  
    def y_middle
      draw.y2
    end
end

class NextCoordinates
    def initialize(x, y, x_velocity, y_velocity)
      @x = x
      @y = y
      @x_velocity = x_velocity
      @y_velocity = y_velocity
    end
  
    def x
      @x + (@x_velocity * [x_length, y_length].min)
    end
  
    def y
      @y + (@y_velocity * [x_length, y_length].min)
    end
  
    def hit_top_or_bottom?
      x_length > y_length
    end
  
    private
  
    def x_length
      if @x_velocity > 0
        (Window.width - Paddle::X_OFFSET - @x) / @x_velocity
      else
        (@x - Paddle::X_OFFSET) / -@x_velocity
      end
    end
  
    def y_length
      if @y_velocity > 0
        (Window.height - @y) / @y_velocity
      else
        @y / -@y_velocity
      end
    end
end