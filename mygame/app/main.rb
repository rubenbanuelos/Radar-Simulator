require_relative '/radar/draw'

class Game
  
  def initialize args
    args.state.timer ||= 0
  end

  def tick args
    args.state.timer += 1

    draw_background args
    draw_target(args)

  end

end

def tick args
  $game = Game.new(args)
  $game.tick args
end

def reset args
  $game = nil
end