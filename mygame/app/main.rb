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
      "WGR"     => Waypoint.new("Whitegrass",       Position.new(182.71, 61.31) ),
      "JOH"     => Waypoint.new("Johnstone Point",  Position.new(115.73, 62.82) ),
      "MNL"     => Waypoint.new("Mineral Creek",    Position.new(123.46, 105.48)),
      "ANC"     => Waypoint.new("Anchorage",        Position.new(9.5,   109.68) ),
      "MDO"     => Waypoint.new("Middleton Island", Position.new(121.44,  1.84) ),
      "JOVOM"   => Waypoint.new("JOVOM",            Position.new(207.61, 37.79) ),
      "FORAT"   => Waypoint.new("FORAT",            Position.new(191.65, 42.16) ),
      "OXUGE"   => Waypoint.new("OXUGE",            Position.new(190.81, 43.26) ),
      "KATAT"   => Waypoint.new("KATAT",            Position.new(175.36, 46.36) ),
      "MODDS"   => Waypoint.new("MODDS",            Position.new(93.56,  23.52) ),
      "DEALS"   => Waypoint.new("DEALS",            Position.new(89.53,  16.96) ),
      "WUXAN"   => Waypoint.new("WUXAN",            Position.new(40.48,  26.04) ),
      "SEWAR"   => Waypoint.new("SEWAR",            Position.new(20.32,  49.55) ),
      "MURYY"   => Waypoint.new("MURYY",            Position.new(35.61,  68.20) ),
      "HATUL"   => Waypoint.new("HATUL",            Position.new(13.77,  87.01) ),
      "HOPER"   => Waypoint.new("HOPER",            Position.new(22.00,  89.53) ),
      "SNRIS"   => Waypoint.new("SNRIS",            Position.new(28.22,  94.73) ),
      "5MRWY02" => Waypoint.new("5MRWY02",          Position.new(183.76, 66.01) ),
      "5MRWY20" => Waypoint.new("5MRWY20",          Position.new(180.40, 56.44) ),
      "5MRWY07" => Waypoint.new("5MRWY07",          Position.new(14.46, 111.53) ),
      "5MRWY25" => Waypoint.new("5MRWY25",          Position.new(5.04,  108.00) )
    }

    @s.add_aircraft_to_lobby("N901AST")
    @s.lobby["N901AST"].type = "B06"
    @s.lobby["N901AST"].wake_category = "L"
    @s.lobby["N901AST"].altitude = 6500.0
    @s.lobby["N901AST"].ias = 95.0
    @s.lobby["N901AST"].heading = 290
    @s.lobby["N901AST"].position = Position.new(211.98, 57.45)
    @s.lobby["N901AST"].assigned_waypoint = @s.waypoints["WGR"]
    @s.lobby["N901AST"].radar_target.tag_position = "TL"
    @s.lobby["N901AST"].load_profile_sheet("Helicopter")
    @s.lobby["N901AST"].radar_target.mode_charlie = false

    @s.add_aircraft_to_lobby("ASA66")
    @s.lobby["ASA66"].type = "B738"
    @s.lobby["ASA66"].wake_category = "M"
    @s.lobby["ASA66"].altitude = 38000.0
    @s.lobby["ASA66"].ias = 250.0
    @s.lobby["ASA66"].heading = 290
    @s.lobby["ASA66"].position = Position.new(211.64, 36.72)
    @s.lobby["ASA66"].assigned_waypoint = @s.waypoints["JOH"]
    @s.lobby["ASA66"].radar_target.tag_position = "BR"
    @s.lobby["ASA66"].load_profile_sheet("Jet")
    @s.lobby["ASA66"].radar_target.in_control = false
    
    @s.add_aircraft_to_lobby("AAL1151")
    @s.lobby["AAL1151"].type = "B752"
    @s.lobby["AAL1151"].wake_category = "H"
    @s.lobby["AAL1151"].altitude = 1000.0
    @s.lobby["AAL1151"].assigned_altitude = 35000.0
    @s.lobby["AAL1151"].ias = 190.0
    @s.lobby["AAL1151"].heading = 70
    @s.lobby["AAL1151"].position = Position.new(11.76, 110.69)
    @s.lobby["AAL1151"].radar_target.tag_position = "TR"
    @s.lobby["AAL1151"].load_profile_sheet("Jet")
    @s.lobby["AAL1151"].radar_target.in_control = false

    @s.add_aircraft_to_lobby("ACA1971")
    @s.lobby["ACA1971"].type = "A321"
    @s.lobby["ACA1971"].wake_category = "M"
    @s.lobby["ACA1971"].altitude = 36000.0
    @s.lobby["ACA1971"].ias = 220.0
    @s.lobby["ACA1971"].heading = 200.0
    @s.lobby["ACA1971"].position = Position.new(131.69, 117.07)
    @s.lobby["ACA1971"].assigned_waypoint = @s.waypoints["JOH"]
    @s.lobby["ACA1971"].radar_target.tag_position = "BR"
    @s.lobby["ACA1971"].load_profile_sheet("Jet")
    @s.lobby["ACA1971"].radar_target.in_control = false

    @s.add_aircraft("DAL7163")
    @s.aircrafts["DAL7163"].type = "763"
    @s.aircrafts["DAL7163"].wake_category = "H"
    @s.aircrafts["DAL7163"].altitude = 34000.0
    @s.aircrafts["DAL7163"].ias = 300.0
    @s.aircrafts["DAL7163"].heading = 290.0
    @s.aircrafts["DAL7163"].position = Position.new(111.70, 64.20)
    @s.aircrafts["DAL7163"].assigned_waypoint = @s.waypoints["SNRIS"]
    @s.aircrafts["DAL7163"].radar_target.tag_position = "BR"
    @s.aircrafts["DAL7163"].load_profile_sheet("Jet")
    @s.aircrafts["DAL7163"].assigned_altitude = 20000
    
    @s.add_aircraft("NRA17")
    @s.aircrafts["NRA17"].type = "DHC6"
    @s.aircrafts["NRA17"].wake_category = "M"
    @s.aircrafts["NRA17"].altitude = 11000.0
    @s.aircrafts["NRA17"].assigned_altitude = 8000.0
    @s.aircrafts["NRA17"].ias = 200.0
    @s.aircrafts["NRA17"].assigned_speed = 200.0
    @s.aircrafts["NRA17"].heading = 290.0
    @s.aircrafts["NRA17"].position = Position.new(42.32, 89.70)
    @s.aircrafts["NRA17"].assigned_waypoint = @s.waypoints["SNRIS"]
    @s.aircrafts["NRA17"].radar_target.tag_position = "BR"
    @s.aircrafts["NRA17"].load_profile_sheet("Jet")

    @s.add_aircraft("QXE178")
    @s.aircrafts["QXE178"].type = "DH8D"
    @s.aircrafts["QXE178"].wake_category = "M"
    @s.aircrafts["QXE178"].altitude = 500.0
    @s.aircrafts["QXE178"].assigned_altitude = 25000.0
    @s.aircrafts["QXE178"].ias = 120.0
    @s.aircrafts["QXE178"].heading = 20
    @s.aircrafts["QXE178"].position = Position.new(182.58,62.48)
    @s.aircrafts["QXE178"].radar_target.tag_position = "TL"
    @s.aircrafts["QXE178"].load_profile_sheet("Turboprop Multi-Engine")


    @s.events = {
      5    => -> { @s.spawn_aicraft(@s.lobby["N901AST"]) },
      10   => -> { @s.aircrafts["N901AST"].assigned_waypoint = @s.waypoints["WGR"] },
      50   => -> { @s.aircrafts["QXE178"].assigned_heading = 225 },
      60   => -> { @s.spawn_aicraft(@s.lobby["ACA1971"]) },
      65   => -> { @s.aircrafts["QXE178"].assigned_waypoint = @s.waypoints["WGR"] },
      88   => -> { @s.aircrafts["N901AST"].radar_target.mode_charlie = true },
      90   => -> { @s.aircrafts["ACA1971"].receive_handover_request },
      100  => -> { @s.spawn_aicraft(@s.lobby["AAL1151"]) },
      125  => -> { @s.aircrafts["NRA17"].send_handover_request },
      135  => -> { @s.aircrafts["NRA17"].radar_target.in_control = false },
      136  => -> { @s.aircrafts["NRA17"].assigned_speed = 160 },
      140  => -> { @s.aircrafts["AAL1151"].assigned_heading = 180 },
      150  => -> { @s.aircrafts["NRA17"].assigned_altitude = 2000 },
      160  => -> { @s.aircrafts["QXE178"].assigned_waypoint = @s.waypoints["JOVOM"] },
      165  => -> { @s.aircrafts["NRA17"].assigned_waypoint = @s.waypoints["ANC"] },
      245  => -> { @s.aircrafts["AAL1151"].assigned_waypoint = @s.waypoints["SNRIS"] },
      260  => -> { @s.aircrafts["NRA17"].assigned_waypoint = nil },
      265  => -> { @s.aircrafts["NRA17"].assigned_heading = 270 },
      320  => -> { @s.spawn_aicraft(@s.lobby["ASA66"]) },
      330  => -> { @s.aircrafts["DAL7163"].assigned_altitude = 8000 },
      355  => -> { @s.aircrafts["AAL1151"].receive_handover_request },
      390  => -> { @s.aircrafts["ASA66"].receive_handover_request },
      400  => -> { @s.aircrafts["AAL1151"].assigned_waypoint = @s.waypoints["JOH"] },
      430  => -> { @s.aircrafts["ACA1971"].assigned_waypoint = @s.waypoints["SNRIS"] },
      470  => -> { @s.aircrafts["ACA1971"].assigned_altitude = 20000 },
      505  => -> { @s.aircrafts["QXE178"].send_handover_request },
      510  => -> { @s.aircrafts["QXE178"].radar_target.in_control = false },
      520  => -> { @s.aircrafts["NRA17"].assigned_waypoint = @s.waypoints["5MRWY25"] },
      600  => -> { @s.aircrafts["NRA17"].assigned_altitude = 1000 },
      680  => -> { @s.aircrafts["NRA17"].assigned_waypoint = @s.waypoints["ANC"] },
      835  => -> { @s.aircrafts["ACA1971"].assigned_altitude = 8000 },
      840  => -> { @s.aircrafts["ACA1971"].assigned_speed = 280 }
    }




    @s.begin_session args

  end

  def tick args
    args.state.timer += 1
    @s.refresh_screen args

    #begin flight update loop
    if args.state.timer % 12 == 0
      @s.do_event(args.state.timer)
      @s.step
    end

    if args.state.timer % 60 == 0
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