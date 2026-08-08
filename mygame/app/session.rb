require_relative 'aircraft'
require_relative 'waypoint'
require_relative 'weather'
require_relative 'draw'

class Session
  #Class containing a radar session
  attr_accessor :aircrafts, :waypoints, :weather, :sector, :time, :tz, :events 
  
  def initialize
    @aircrafts = {}
    @waypoints = {}
    @weather = Weather.new
    @sector = ""
    time = Time.new
    tz = ""
  end

  def add_aircraft(callsign)
    @aircrafts[callsign] = Aircraft.new(callsign)
  end

  def begin_session args
    draw_background args #Draws background
    @aircrafts.each_value do |aircraft| #draws aircrafts in initial positions
      aircraft.update_target
      aircraft.populate_ghosts
      
      draw_target(args, aircraft.radar_target) #draw targets and ghosts
      if aircraft.radar_target.in_control
        draw_tag(args, aircraft.radar_target) #draw tags for aircraft in control
      end

    end
  end

end