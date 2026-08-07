require_relative 'radar/session'

class Game
  
  def initialize args
    args.state.timer ||= 0
  end

  def tick args
    args.state.timer += 1

    s = Session.new
    s.begin_session

  end

end

def tick args
  $game = Game.new(args)
  $game.tick args
end

def reset args
  $game = nil
end