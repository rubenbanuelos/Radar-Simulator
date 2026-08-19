require_relative 'session'
require_relative 'weather'
require_relative 'vectors'
require_relative 'alert'
require_relative 'profile_sheet'

class Game

  attr_accessor :s
  
  def initialize args
    args.state.timer ||= 0

    @profiles = parse_profiles

    @s = Session.new
    
    @s.sector = "PAZA  -  ANCHORAGE CENTER"
    @s.freq   = "SECTOR 13     130.200 MHZ"
    @s.time = Time.new(2009,11,13,16,31,19)
    @s.tz = "AST"
    @s.time_diff = -8

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

    }

 
    @s.events = {
    }

    @s.add_aircraft("TEST")
    @s.aircrafts["TEST"].altitude = 3000
    @s.aircrafts["TEST"].ias = 200
    @s.aircrafts["TEST"].load_profile_sheet("Helicopter")
    @s.aircrafts["TEST"].position = Position.new(100,50)
    @s.aircrafts["TEST"].assigned_altitude = 2000
    #@s.aircrafts["TEST"].radar_target.emergency = true
    #@s.aircrafts["TEST"].radar_target.mva = true    

    @s.alerts["Hola"] = Alert.new(@s.aircrafts["TEST"], "Sent Handover")



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