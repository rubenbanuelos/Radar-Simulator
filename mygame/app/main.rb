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

    @s.add_aircraft_to_lobby("N91AST")
    @s.lobby["N91AST"].type = "B06"
    @s.lobby["N91AST"].wake_category = "L"
    @s.lobby["N91AST"].altitude = 6500.0
    @s.lobby["N91AST"].ias = 95.0
    @s.lobby["N91AST"].heading = 290
    @s.lobby["N91AST"].position = Position.new(211.98, 57.45)
    @s.lobby["N91AST"].assigned_waypoint = @s.waypoints["WGR"]
    @s.lobby["N91AST"].radar_target.tag_position = "TL"
    @s.lobby["N91AST"].load_profile_sheet("Helicopter")
    @s.lobby["N91AST"].radar_target.squawk_ifr = false

    @s.add_aircraft_to_lobby("N721SQ")
    @s.lobby["N721SQ"].type = "B738"
    @s.lobby["N721SQ"].wake_category = "M"
    @s.lobby["N721SQ"].altitude = 38000.0
    @s.lobby["N721SQ"].ias = 250.0
    @s.lobby["N721SQ"].heading = 290
    @s.lobby["N721SQ"].position = Position.new(211.64, 36.72)
    @s.lobby["N721SQ"].assigned_waypoint = @s.waypoints["JOH"]
    @s.lobby["N721SQ"].radar_target.tag_position = "BR"
    @s.lobby["N721SQ"].load_profile_sheet("Jet")
    @s.lobby["N721SQ"].radar_target.in_control = false

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

    @s.add_aircraft("FDX792")
    @s.aircrafts["FDX792"].type = "B77L"
    @s.aircrafts["FDX792"].wake_category = "H"
    @s.aircrafts["FDX792"].altitude = 37000.0
    @s.aircrafts["FDX792"].ias = 250.0
    @s.aircrafts["FDX792"].heading = 60.0
    @s.aircrafts["FDX792"].position = Position.new(40.48,  26.04)
    @s.aircrafts["FDX792"].assigned_waypoint = @s.waypoints["JOH"]
    @s.aircrafts["FDX792"].radar_target.tag_position = "BR"
    @s.aircrafts["FDX792"].load_profile_sheet("Jet")

    @s.add_aircraft("DAL7163")
    @s.aircrafts["DAL7163"].type = "B763"
    @s.aircrafts["DAL7163"].wake_category = "H"
    @s.aircrafts["DAL7163"].altitude = 34000.0
    @s.aircrafts["DAL7163"].ias = 300.0
    @s.aircrafts["DAL7163"].heading = 290.0
    @s.aircrafts["DAL7163"].position = Position.new(111.70, 64.20)
    @s.aircrafts["DAL7163"].assigned_waypoint = @s.waypoints["SNRIS"]
    @s.aircrafts["DAL7163"].radar_target.tag_position = "BR"
    @s.aircrafts["DAL7163"].load_profile_sheet("Jet")
    @s.aircrafts["DAL7163"].assigned_altitude = 20000

    @s.add_aircraft("ASA66")
    @s.aircrafts["ASA66"].type = "B738"
    @s.aircrafts["ASA66"].wake_category = "M"
    @s.aircrafts["ASA66"].altitude = 35000.0
    @s.aircrafts["ASA66"].ias = 300.0
    @s.aircrafts["ASA66"].heading = 110.0
    @s.aircrafts["ASA66"].position = Position.new(175.36, 46.36)
    @s.aircrafts["ASA66"].assigned_waypoint = @s.waypoints["JOVOM"]
    @s.aircrafts["ASA66"].radar_target.tag_position = "BR"
    @s.aircrafts["ASA66"].load_profile_sheet("Jet")
    
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
    @s.aircrafts["QXE178"].radar_target.tag_position = "BR"
    @s.aircrafts["QXE178"].load_profile_sheet("Turboprop Multi-Engine")


    @s.events = {
      5    => -> { @s.spawn_aicraft(@s.lobby["N91AST"]) },
      10   => -> { @s.aircrafts["N91AST"].assigned_waypoint = @s.waypoints["WGR"] },
      50   => -> { @s.aircrafts["QXE178"].assigned_heading = 225 },
      60   => -> { @s.spawn_aicraft(@s.lobby["ACA1971"]) },
      65   => -> { @s.aircrafts["QXE178"].assigned_waypoint = @s.waypoints["WGR"] },
      88   => -> { @s.aircrafts["N91AST"].radar_target.squawk_ifr = true },
      89   => -> { @s.aircrafts["N91AST"].autopilot.alert(" *IDENT*")},
      90   => -> { @s.aircrafts["ACA1971"].receive_handover_request },
      100  => -> { @s.spawn_aicraft(@s.lobby["AAL1151"]) },
      125  => -> { @s.aircrafts["NRA17"].send_handover_request },
      135  => -> { @s.aircrafts["NRA17"].radar_target.in_control = false },
      136  => -> { @s.aircrafts["NRA17"].assigned_speed = 160 },
      140  => -> { @s.aircrafts["AAL1151"].assigned_heading = 180 },
      150  => -> { @s.aircrafts["NRA17"].assigned_altitude = 2000 },
      160  => -> { @s.aircrafts["QXE178"].assigned_waypoint = @s.waypoints["JOVOM"] },
      165  => -> { @s.aircrafts["NRA17"].assigned_waypoint = @s.waypoints["ANC"] },
      175  => -> { @s.aircrafts["ASA66"].send_handover_request },
      185  => -> { @s.aircrafts["ASA66"].radar_target.in_control = false },
      215  => -> { @s.aircrafts.delete("ASA66") },
      230  => -> { @s.aircrafts["FDX792"].assigned_altitude = 39000 },
      236  => -> { @s.aircrafts["N91AST"].assigned_waypoint = nil },
      237  => -> { @s.aircrafts["N91AST"].ias = 88},
      238  => -> { @s.aircrafts["N91AST"].altitude = 6300},
      239  => -> { @s.aircrafts["N91AST"].heading = 250},
      242  => -> { @s.aircrafts["N91AST"].ias = 95},
      243  => -> { @s.aircrafts["N91AST"].altitude = 6100},
      244  => -> { @s.aircrafts["N91AST"].heading = 235},
      245  => -> { @s.aircrafts["AAL1151"].assigned_waypoint = @s.waypoints["SNRIS"] },
      247  => -> { @s.aircrafts["N91AST"].ias = 106},
      248  => -> { @s.aircrafts["N91AST"].altitude = 5900},
      249  => -> { @s.aircrafts["N91AST"].heading = 220},
      252  => -> { @s.aircrafts["N91AST"].ias = 116},
      253  => -> { @s.aircrafts["N91AST"].altitude = 5500},
      254  => -> { @s.aircrafts["N91AST"].heading = 180},
      257  => -> { @s.aircrafts["N91AST"].ias = 116},
      258  => -> { @s.aircrafts["N91AST"].altitude = 5400},
      260  => -> { @s.aircrafts["NRA17"].assigned_waypoint = nil },
      252  => -> { @s.aircrafts["N91AST"].ias = 110},
      253  => -> { @s.aircrafts["N91AST"].altitude = 5500},
      254  => -> { @s.aircrafts["N91AST"].heading = 180},
      257  => -> { @s.aircrafts["N91AST"].ias = 100},
      258  => -> { @s.aircrafts["N91AST"].altitude = 5700},
      259  => -> { @s.aircrafts["N91AST"].heading = 200},
      262  => -> { @s.aircrafts["N91AST"].ias = 90},
      263  => -> { @s.aircrafts["N91AST"].altitude = 5800},
      264  => -> { @s.aircrafts["N91AST"].heading = 220},
      265  => -> { @s.aircrafts["NRA17"].assigned_heading = 270 },
      267  => -> { @s.aircrafts["N91AST"].ias = 85},
      268  => -> { @s.aircrafts["N91AST"].altitude = 5900},
      269  => -> { @s.aircrafts["N91AST"].heading = 250},
      272  => -> { @s.aircrafts["N91AST"].ias = 90},
      273  => -> { @s.aircrafts["N91AST"].altitude = 6000},
      274  => -> { @s.aircrafts["N91AST"].heading = 200},
      277  => -> { @s.aircrafts["N91AST"].ias = 100},
      278  => -> { @s.aircrafts["N91AST"].altitude = 6100},
      282  => -> { @s.aircrafts["N91AST"].heading = 220},
      283  => -> { @s.aircrafts["N91AST"].ias = 105},
      284  => -> { @s.aircrafts["N91AST"].altitude = 5900},
      287  => -> { @s.aircrafts["N91AST"].radar_target.emergency = true},
      288  => -> { @s.aircrafts["N91AST"].heading = 200},
      289  => -> { @s.aircrafts["N91AST"].ias = 100},
      292  => -> { @s.aircrafts["N91AST"].altitude = 5700},
      293  => -> { @s.aircrafts["N91AST"].heading = 180},
      294  => -> { @s.aircrafts["N91AST"].ias = 106},
      297  => -> { @s.aircrafts["N91AST"].altitude = 5500},
      298  => -> { @s.aircrafts["N91AST"].heading = 160},
      299  => -> { @s.aircrafts["N91AST"].ias = 112},
      302  => -> { @s.aircrafts["N91AST"].altitude = 5300},
      303  => -> { @s.aircrafts["N91AST"].heading = 150},
      304  => -> { @s.aircrafts["N91AST"].ias = 115},
      307  => -> { @s.aircrafts["N91AST"].altitude = 5200},
      308  => -> { @s.aircrafts["N91AST"].heading = 180},
      309  => -> { @s.aircrafts["N91AST"].ias = 110},
      312  => -> { @s.aircrafts["N91AST"].altitude = 5100},
      313  => -> { @s.aircrafts["N91AST"].heading = 220},
      314  => -> { @s.aircrafts["N91AST"].ias = 106},
      317  => -> { @s.aircrafts["N91AST"].altitude = 5000},
      318  => -> { @s.aircrafts["N91AST"].heading = 250},
      319  => -> { @s.aircrafts["N91AST"].ias = 107},
      320  => -> { @s.spawn_aicraft(@s.lobby["N721SQ"]) },
      322  => -> { @s.aircrafts["N91AST"].altitude = 5000},
      323  => -> { @s.aircrafts["N91AST"].heading = 270},
      324  => -> { @s.aircrafts["N91AST"].ias = 109},
      327  => -> { @s.aircrafts["N91AST"].altitude = 5000},
      328  => -> { @s.aircrafts["N91AST"].heading = 270},
      329  => -> { @s.aircrafts["N91AST"].ias = 107},
      330  => -> { @s.aircrafts["DAL7163"].assigned_altitude = 8000 },
      332  => -> { @s.aircrafts["N91AST"].altitude = 4900},
      333  => -> { @s.aircrafts["N91AST"].heading = 250},
      334  => -> { @s.aircrafts["N91AST"].ias = 110},
      337  => -> { @s.aircrafts["N91AST"].altitude = 4800},
      338  => -> { @s.aircrafts["N91AST"].heading = 230},
      339  => -> { @s.aircrafts["N91AST"].ias = 100},
      342  => -> { @s.aircrafts["N91AST"].altitude = 4700},
      343  => -> { @s.aircrafts["N91AST"].heading = 210},
      344  => -> { @s.aircrafts["N91AST"].ias = 100},
      342  => -> { @s.aircrafts["N91AST"].altitude = 4600},
      343  => -> { @s.aircrafts["N91AST"].heading = 220},
      344  => -> { @s.aircrafts["N91AST"].ias = 95},
      345  => -> { @s.aircrafts["N91AST"].radar_target.mva = true },
      347  => -> { @s.aircrafts["N91AST"].altitude = 4500},
      348  => -> { @s.aircrafts["N91AST"].heading = 230},
      349  => -> { @s.aircrafts["N91AST"].ias = 99},
      352  => -> { @s.aircrafts["N91AST"].altitude = 4400},
      353  => -> { @s.aircrafts["N91AST"].heading = 230},
      354  => -> { @s.aircrafts["N91AST"].ias = 98},
      355  => -> { @s.aircrafts["AAL1151"].receive_handover_request },
      357  => -> { @s.aircrafts["N91AST"].altitude = 4400},
      358  => -> { @s.aircrafts["N91AST"].heading = 240},
      359  => -> { @s.aircrafts["N91AST"].ias = 98},
      360  => -> { @s.aircrafts["N91AST"].radar_target.contact_lost = true},
      362  => -> { @s.aircrafts["N91AST"].altitude = 4400},
      363  => -> { @s.aircrafts["N91AST"].heading = 240},
      364  => -> { @s.aircrafts["N91AST"].ias = 102},
      365  => -> { @s.aircrafts["N91AST"].radar_target.contact_lost = false},
      367  => -> { @s.aircrafts["N91AST"].altitude = 4100},
      368  => -> { @s.aircrafts["N91AST"].heading = 240},
      369  => -> { @s.aircrafts["N91AST"].ias = 98},
      372  => -> { @s.aircrafts["N91AST"].altitude = 4000},
      373  => -> { @s.aircrafts["N91AST"].heading = 260},
      374  => -> { @s.aircrafts["N91AST"].ias = 96},
      377  => -> { @s.aircrafts["N91AST"].altitude = 3900},
      378  => -> { @s.aircrafts["N91AST"].heading = 180},
      379  => -> { @s.aircrafts["N91AST"].ias = 70},
      382  => -> { @s.aircrafts["N91AST"].altitude = 3700},
      383  => -> { @s.aircrafts["N91AST"].heading = 180},
      384  => -> { @s.aircrafts["N91AST"].ias = 66},
      387  => -> { @s.aircrafts["N91AST"].altitude = 3500},
      388  => -> { @s.aircrafts["N91AST"].heading = 180},
      389  => -> { @s.aircrafts["N91AST"].ias = 59},
      390  => -> { @s.aircrafts["N721SQ"].receive_handover_request },
      392  => -> { @s.aircrafts["N91AST"].altitude = 3500},
      393  => -> { @s.aircrafts["N91AST"].heading = 180},
      394  => -> { @s.aircrafts["N91AST"].ias = 59},
      395  => -> { @s.aircrafts["N91AST"].radar_target.contact_lost = true},
      397  => -> { @s.aircrafts["N91AST"].altitude = 3500},
      398  => -> { @s.aircrafts["N91AST"].heading = 180},
      399  => -> { @s.aircrafts["N91AST"].ias = 59},
      400  => -> { @s.aircrafts["AAL1151"].assigned_waypoint = @s.waypoints["JOH"] },
      402  => -> { @s.aircrafts["N91AST"].altitude = 3200},
      403  => -> { @s.aircrafts["N91AST"].heading = 180},
      404  => -> { @s.aircrafts["N91AST"].ias = 55},
      405  => -> { @s.aircrafts["N91AST"].radar_target.contact_lost = false},
      407  => -> { @s.aircrafts["N91AST"].altitude = 3200},
      408  => -> { @s.aircrafts["N91AST"].heading = 180},
      409  => -> { @s.aircrafts["N91AST"].ias = 55},
      410  => -> { @s.aircrafts["N91AST"].radar_target.contact_lost = true},
      412  => -> { @s.aircrafts["N91AST"].altitude = 3200},
      413  => -> { @s.aircrafts["N91AST"].heading = 180},
      414  => -> { @s.aircrafts["N91AST"].ias = 55},
      420  => -> { @s.aircrafts["N91AST"].radar_target.contact_lost_stage_2 = true},
      426  => -> { @s.aircrafts.delete("N91AST") },
      430  => -> { @s.aircrafts["ACA1971"].assigned_waypoint = @s.waypoints["SNRIS"] },
      470  => -> { @s.aircrafts["ACA1971"].assigned_altitude = 20000 },
      505  => -> { @s.aircrafts["QXE178"].send_handover_request },
      510  => -> { @s.aircrafts["QXE178"].radar_target.in_control = false },
      520  => -> { @s.aircrafts["NRA17"].assigned_waypoint = @s.waypoints["5MRWY25"] },
      600  => -> { @s.aircrafts["NRA17"].assigned_altitude = 1000 },
      650  => -> { @s.aircrafts["NRA17"].assigned_waypoint = @s.waypoints["ANC"] },
      835  => -> { @s.aircrafts["ACA1971"].assigned_altitude = 8000 },
      840  => -> { @s.aircrafts["ACA1971"].assigned_speed = 280 }
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