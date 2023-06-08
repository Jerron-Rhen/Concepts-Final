require 'ruby2d'

require './lib/board'
require './lib/ball'
require './lib/paddle'

set title: 'Pong', background: 'black', width: 960, height: 720#, resizable: false

PONG_SOUND = Sound.new('./SFX/pong.wav')
PING_SOUND = Sound.new('./SFX/ping.wav')

ball_velocity = 6

player = Paddle.new(:left, 8, 0, 285)
opponent = Paddle.new(:right, 8, 0, 285)
ball = Ball.new(ball_velocity)
ball_trajectory = BallTrajectory.new(ball)
scoreBoard = ScoreBoard.new(0,0)

Slist = ['./SFX/We-are-Finally-Landing.mp3','./SFX/Feel-Good','./SFX/On-The-Prowl(rX).mp3','./SFX/music.wav',
    './SFX/Nuclear-Winter.mp3','./SFX/Fogger (R).mp3','./SFX/Mechanical-Man(R).mp3','./SFX/Valves.mp3','./SFX/Scouting.mp3',
    './SFX/Mutants.mp3','./SFX/Brimstone.mp3','./SFX/Brain-Freeze (R).mp3','./SFX/Grinder.mp3','./SFX/Hell-March(R).mp3',
    './SFX/Femme-Fatale.mp3','./SFX/Queen-of-Knives.mp3','./SFX/Electro-Cabello.mp3']

bgm = Music.new(Slist.sample)
bgm.loop = true
bgm.play

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