require 'ruby2d'

require './lib/board'
require './lib/ball'
require './lib/paddle'

set title: 'Pong', background: 'black', with: 9000, height: 480#, resizable: false

PONG_SOUND = Sound.new('./SFX/pong.wav')
PING_SOUND = Sound.new('./SFX/ping.wav')

ball_velocity = 8

player = Paddle.new(:left, 5, 0, 200)
opponent = Paddle.new(:right, 5, 0, 200)
ball = Ball.new(ball_velocity)
ball_trajectory = BallTrajectory.new(ball)
scoreBoard = ScoreBoard.new(0,0)

bmg = Music.new('./SFX/music.wav')
bmg.loop = true
bmg.play

last_hit_frame = 0

update do
  clear

  DividingLine.new.draw

  if player.hit_ball?(ball)
    ball.bounce_off(player)
    PING_SOUND.play
    last_hit_frame = Window.frames
    player = Paddle.new(:left, 5, rand(4), player.y)
  end

  if opponent.hit_ball?(ball)
    ball.bounce_off(opponent)
    PING_SOUND.play
    last_hit_frame = Window.frames
    opponent = Paddle.new(:right, 5, rand(4), opponent.y)
  end

  scoreBoard.draw
  
  player.move
  player.draw

  ball.move
  ball.draw

  ball_trajectory.draw

# opponent.track_ball(ball_trajectory, last_hit_frame)
  opponent.move
  opponent.draw

  if ball.out_of_bounds?
    if ball.x <= 100
      scoreBoard.OScore += 1
    else
      scoreBoard.PScore += 1
    end
    ball = Ball.new(ball_velocity)
    ball_trajectory = BallTrajectory.new(ball)
  end
end

on :key_held do |event|
    if event.key == 'w'
    player.y_movement = -1
    elsif event.key == 's'
    player.y_movement = 1
    elsif event.key == 'up'
    opponent.y_movement = -1
    elsif event.key == 'down'
    opponent.y_movement = 1
  end
end

on :key_up do |event|
  player.y_movement = 0
  opponent.y_movement = 0
end

show