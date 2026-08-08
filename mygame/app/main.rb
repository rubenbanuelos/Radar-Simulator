require_relative 'session'
require_relative 'weather'
require_relative 'vectors'

class Game

  attr_accessor :s
  
  def initialize args
    args.state.timer ||= 0

     @s = Session.new

     puts "Inicializando"

    winds = [
      Profile.new(Wind.new(5.0, 70.0), 0),
      Profile.new(Wind.new(12.0, 120.0), 1000),
      Profile.new(Wind.new(18.0, 170.0), 5000),
      Profile.new(Wind.new(25.0, 225.0), 10000),
      Profile.new(Wind.new(38.0, 190.0), 25000),
      Profile.new(Wind.new(55.0 ,155.0), 45000)
    ]

    temperatures = [
      Profile.new(10.0, 0),
      Profile.new(0.0, 3000),
      Profile.new(-10.0,10000),
      Profile.new(-20.0, 20000),
      Profile.new(-40.0, 50000)
    ]

    weather = Weather.new
    weather.altimeter = 29.72
    weather.wind_layers = winds
    weather.temperature_layers = temperatures

    @s.weather = weather

    @s.waypoints["WGR"] = Waypoint.new(
      "WGR",
      Position.new(177.21,66.17)
    )

    @s.add_aircraft("N901AST")
    @s.aircrafts["N901AST"].type = "B06"
    @s.aircrafts["N901AST"].wake_category = "L"
    @s.aircrafts["N901AST"].altitude = 6500.0
    @s.aircrafts["N901AST"].ias = 95.0
    @s.aircrafts["N901AST"].position = Position.new(204.58,33.26)
    @s.aircrafts["N901AST"].assigned_waypoint = s.waypoints["WGR"]
    @s.aircrafts["N901AST"].radar_target.tag_position = "TR"
    @s.aircrafts["N901AST"].load_profile_sheet("Helicopter")

    @s.begin_session args

  end

  def tick args
    args.state.timer += 1
    @s.refresh_screen args

    #begin flight update loop
    if args.state.timer % 60 == 0
      puts "step"
      @s.step
    end

    if args.state.timer % 300 == 0
      puts "step"
      @s.update
    end

  end

end

def tick args
  $game ||= Game.new(args)
  $game.tick args
end

def reset args
  $game = nil
end