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

    @s.weather = parse_weather

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