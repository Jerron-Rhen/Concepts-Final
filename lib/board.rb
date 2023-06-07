class DividingLine
    WIDTH = 15
    HEIGHT = 25
    NUMBER_OF_LINES = 10
    def draw
  
      NUMBER_OF_LINES.times do |i|
        Rectangle.new(x: (Window.width + WIDTH) / 2, y: (Window.height / NUMBER_OF_LINES) * i, height: HEIGHT, width: WIDTH, color: 'white')
      end
    end
  end

  class ScoreBoard

    attr_accessor :OScore,:PScore
    def initialize(pS, oS)
        @OScore = oS 
        @PScore = pS
       # @scoreB = [@OScore, @PScore]
    end
  
    def draw
      left = Text.new(@PScore, x: Window.width / 2 - 100, y: 5, font: 'assets/PressStart2P.ttf', color: 'gray', size: 40)
      right = Text.new(@OScore, x: Window.width / 2 + 60, y: 5, font: 'assets/PressStart2P.ttf', color: 'gray', size: 40)
    end
  
  end