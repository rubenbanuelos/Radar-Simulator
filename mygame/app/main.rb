require_relative 'session'

class Game
  
  def initialize args
    args.state.timer ||= 0
  end

  def tick args
    args.state.timer += 1

    s = Session.new

    s.waypoints["WGR"] = Waypoint.new(
      "WGR",
      Position.new(177.21,66.17)
    )
    s.add_aircraft("N901AST")
    s.aircrafts["N901AST"].type = "B06"
    s.aircrafts["N901AST"].wake_category = "L"
    s.aircrafts["N901AST"].altitude = 6500.0
    s.aircrafts["N901AST"].ias = 95.0
    s.aircrafts["N901AST"].position = Position.new(204.58,33.26)
    s.aircrafts["N901AST"].assigned_waypoint = s.waypoints["WGR"]


    s.begin_session args

  end

end

def tick args
  $game = Game.new(args)
  $game.tick args
end

def reset args
  $game = nil
end