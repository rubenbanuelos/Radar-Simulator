require_relative 'session'
require_relative 'weather'
require_relative 'vectors'
require_relative 'alert'
require_relative 'profile_sheet'
require_relative 'populate'
require_relative 'events'

class Game

  attr_accessor :s
  
  def initialize args
    args.state.timer ||= 0
    
    profiles = parse_profiles

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

    @s.waypoints = parse_waypoints 

    populate(@s)

    add_events(@s)




    @s.begin_session args

  end

  def tick args
    args.state.timer += 1
    @s.refresh_screen args
    @s.update args
    #begin flight update loop
    if args.state.timer % 60 == 0
      @s.do_event(args.state.timer)
      @s.step
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