class Paddle
    HEIGHT = 150
    JITTER_CORRECTION = 4
    X_OFFSET = 40
    OPPONENT_MOVE_DELAY_FRAMES = 30
  
    attr_writer :y_movement
    attr_reader :side
  
    def initialize(side, movement_speed, num)
      @side = side
      @movement_speed = movement_speed
      @num = num
      @y_movement = 0
      @y = 200
      if side == :left
        @x = X_OFFSET
      else
        @x = Window.width - X_OFFSET
      end
    end
  
    def move
      @y = (@y + @y_movement * @movement_speed).clamp(0, max_y)
    end
  
    def draw
      #@shape = Rectangle.new(x: @x, y: @y, width: 25, height: HEIGHT, color: 'white')
      if @side == :left
        if @num == 0
          @shape = Rectangle.new(x: @x, y: @y, width: 25, height: HEIGHT, color: 'white')
        elsif @num == 1
          @shape = Rectangle.new(x: @x, y: @y, width: 25, height: HEIGHT - 50, color: 'white')
        elsif @num == 2
          @shape = Quad.new(x1: @x + 20, y1: @y, x2: @x + 40, y2: @y + 75, x3: @x + 20, y3: @y + 150, x4: @x, y4: @y + 75, color: 'white')
        elsif @num == 3
          @shape = Square.new(x: @x, y: @y, size: HEIGHT - 60, color: 'white')
        end
      else
        if @num == 0
          @shape = Rectangle.new(x: @x, y: @y, width: 25, height: HEIGHT, color: 'white')
        elsif @num == 1
          @shape = Rectangle.new(x: @x, y: @y, width: 25, height: HEIGHT - 50, color: 'white')
        elsif @num == 2
          @shape = Quad.new(x1: @x - 20, y1: @y, x2: @x - 40, y2: @y + 75, x3: @x - 20, y3: @y + 150, x4: @x, y4: @y + 75, color: 'white')
        elsif @num == 3
          @shape = Square.new(x: @x - 70, y: @y, size: HEIGHT - 60, color: 'white')
        end
      end
    end
  
    def hit_ball?(ball)
      ball.shape && [[ball.shape.x1, ball.shape.y1], [ball.shape.x2, ball.shape.y2],
       [ball.shape.x3, ball.shape.y3], [ball.shape.x4, ball.shape.y4]].any? do |coordinates|
        @shape.contains?(coordinates[0], coordinates[1])
      end
    end
  
    def track_ball(ball_trajectory, last_hit_frame)
      if last_hit_frame + OPPONENT_MOVE_DELAY_FRAMES < Window.frames
        if ball_trajectory.y_middle > y_middle + JITTER_CORRECTION
          @y += @movement_speed
        elsif ball_trajectory.y_middle < y_middle - JITTER_CORRECTION
          @y -= @movement_speed
        end
      end
    end
  
    def y1
      @shape.y1
    end
  
    private
  
    def y_middle
      @y + (HEIGHT / 2)
    end
  
    def max_y
      Window.height - HEIGHT
    end
  end