require_relative 'aircraft'
require_relative 'waypoint'
require_relative 'weather'
require_relative 'draw'

class Session
  #Class containing a radar session
  attr_accessor :aircrafts, :waypoints, :weather, :sector, :time, :tz, :events,:freq 
  
  def initialize
    @aircrafts = {}
    @waypoints = {}
    @weather = Weather.new
    @sector = ""
    @freq = ""
    @time = Time.new
    @tz = ""
  end

  def add_aircraft(callsign)
    @aircrafts[callsign] = Aircraft.new(callsign)
  end

  def begin_session args
    #Create Status text
    status = []
    status.push(@sector)
    status.push(@freq)
    
    t_local = format("%02d", @time.hour ).to_s + ":" + format("%02d", @time.min) + ":" + format("%02d", @time.sec)
    t_utc = format("%02d", (@time.hour + 8) % 24).to_s + ":" + format("%02d", @time.min) + ":" + format("%02d", @time.sec)
    
    status.push(t_local + " " + @tz + " " + t_utc + " UTC")

    draw_status(args, status)

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

  def refresh_screen args
    status = []
    status.push(@sector)
    status.push(@freq)
    
    t_local = format("%02d", @time.hour ).to_s + ":" + format("%02d", @time.min) + ":" + format("%02d", @time.sec)
    t_utc = format("%02d", (@time.hour + 8) % 24).to_s + ":" + format("%02d", @time.min) + ":" + format("%02d", @time.sec)
    
    status.push(t_local + " " + @tz + " " + t_utc + " UTC")
  
    draw_status(args, status)
    draw_background args #Draws background
     
    @aircrafts.each_value do |aircraft| #draws aircrafts in initial positions
      
      draw_target(args, aircraft.radar_target) #draw targets and ghosts
      
      if aircraft.radar_target.in_control
        draw_tag(args, aircraft.radar_target) #draw tags for aircraft in control
      end
    end


  end

  def step
    @aircrafts.each_value do |aircraft|
      aircraft.autopilot.fly(weather)
      @time += 1
    end
  end


  def update
    @aircrafts.each_value do |aircraft|
      aircraft.update_target
    end
  end

end