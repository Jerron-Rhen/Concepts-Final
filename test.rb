require 'ruby2d'

set background:'green'
# Define a square shape.
@square = Square.new(x: 10, y: 20, size: 25, color: 'blue')

# Define the initial speed (and direction).
@x_speed = 0
@y_speed = 0

# Define what happens when a specific key is pressed.
# Each keypress influences on the  movement along the x and y axis.
on :key_down do |event|
  if event.key == 'a'
    @x_speed = -5
    @y_speed = 0
  elsif event.key == 'd'
    @x_speed = 5
    @y_speed = 0
  elsif event.key == 'w'
    @x_speed = 0
    @y_speed = -5
  elsif event.key == 's'
    @x_speed = 0
    @y_speed = 5
  end
end

update do
  @square.x += @x_speed
  @square.y += @y_speed
end

show