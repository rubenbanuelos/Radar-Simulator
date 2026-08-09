require_relative 'session'
require_relative 'weather'
require_relative 'vectors'

class Game

  attr_accessor :s
  
  def initialize args
    args.state.timer ||= 0

     @s = Session.new

     @s.sector = "PAZA    -   ANCHORAGE CTR"
     @s.freq   = "SECTOR 13     130.200 MHZ"
     @s.time = Time.new(2009,11,13,16,31,19)
     @s.tz = "AST"

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

    @s.waypoints = {  
      "WGR" => Waypoint.new("Whitegrass",      Position.new(177.21,54.59) ),
      "JOH" => Waypoint.new("Johnstone Point", Position.new(115.73,62.82) ),
      "MNL" => Waypoint.new("Mineral Creek",   Position.new(123.46,105.48)),
      "ANC" => Waypoint.new("Anchorage",       Position.new(9.5,129.68)   )
    }

    @s.add_aircraft_to_lobby("N901AST")
    @s.lobby["N901AST"].type = "B06"
    @s.lobby["N901AST"].wake_category = "L"
    @s.lobby["N901AST"].altitude = 6500.0
    @s.lobby["N901AST"].ias = 95.0
    @s.lobby["N901AST"].position = Position.new(204.58,33.26)
    @s.lobby["N901AST"].assigned_waypoint = s.waypoints["WGR"]
    @s.lobby["N901AST"].radar_target.tag_position = "BL"
    @s.lobby["N901AST"].load_profile_sheet("Helicopter")
    @s.lobby["N901AST"].radar_target.mode_charlie = false

    

    @s.add_aircraft("QXE178")
    @s.aircrafts["QXE178"].type = "DH8D"
    @s.aircrafts["QXE178"].wake_category = "M"
    @s.aircrafts["QXE178"].altitude = 1500.0
    @s.aircrafts["QXE178"].assigned_altitude = 25000.0
    @s.aircrafts["QXE178"].ias = 120.0
    @s.aircrafts["QXE178"].heading = 20
    @s.aircrafts["QXE178"].position = Position.new(179.73,59.13)
    #@s.aircrafts["QXE178"].assigned_waypoint = s.waypoints["WGR"]
    @s.aircrafts["QXE178"].radar_target.tag_position = "BL"
    @s.aircrafts["QXE178"].load_profile_sheet("Turboprop Multi-Engine")
    @s.aircrafts["QXE178"].radar_target.in_control = false


    @s.events = {
      5  => -> { @s.spawn_aicraft(@s.lobby["N901AST"]) },
      61  => -> { @s.aircrafts["QXE178"].radar_target.in_control = true },
      62  => -> { @s.aircrafts["QXE178"].receive_handover_request }
    }




    @s.begin_session args

  end

  def tick args
    args.state.timer += 1
    @s.refresh_screen args

    #begin flight update loop
    if args.state.timer % 60 == 0
      @s.do_event(args.state.timer)
      @s.step
    end

    if args.state.timer % 300 == 0
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