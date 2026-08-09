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
    @events    = {}
    @weather = Weather.new
    @sector  = ""
    @freq    = ""
    @time    = Time.new
    @tz      = ""
  end

  def add_aircraft(callsign)
    @aircrafts[callsign] = Aircraft.new(callsign)
  end

  def begin_session args
    
    @aircrafts.each_value do |aircraft| #draws aircrafts in initial positions
      aircraft.update_target
      aircraft.populate_ghosts
    end
  end

  def refresh_screen args
    gray = [160,160,160,255]
    red = [255,0,0,255]
    yellow = [255,255,0,255]

    status = []
    status.push([@sector,gray])
    status.push([@freq,  gray])
    
    t_local = format("%02d", @time.hour ).to_s + ":" + format("%02d", @time.min) + ":" + format("%02d", @time.sec)
    t_utc = format("%02d", (@time.hour + 8) % 24).to_s + ":" + format("%02d", @time.min) + ":" + format("%02d", @time.sec)
    
    status.push([t_local + " " + @tz + " " + t_utc + " UTC", gray])

    if (@aircrafts.any? {|_, aircraft| aircraft.radar_target.emergency})
      status.push(["**ACTIVE EMERGENCY**", red])
    end

    #if (@aircrafts.all? {|_, aircraft | aircraft.radar_target.emergency == false})
    #  status.delete(["**ACTIVE EMERGENCY**", red])
    #end

    if (@aircrafts.any? {|_, aircraft| aircraft.radar_target.mva})
      status.push(["**VECTORING ALTITUDE**", red])
    end

    #if (@aircrafts.all? {|_, aircraft | aircraft.radar_target.mva == false})
    #  status.delete(["**VECTORING ALTITUDE**", red])
    #end

    if (@aircrafts.any? {|_, aircraft| aircraft.ho_rcv})
      status.push(["RECEIVED HANDOVER REQUEST", yellow])
    end

    #if (@aircrafts.all? {|_, aircraft | aircraft.ho_rcv == false})
    #  status.delete(["RECEIVED HANDOVER REQUEST", yellow])
    #end

    if (@aircrafts.any? {|_, aircraft| aircraft.ho_snt})
      status.push(["SENT HANDOVER REQUEST", yellow])
    end

    #if (@aircrafts.all? {|_, aircraft | aircraft.ho_rcv == false})
    #  status.delete(["SENT HANDOVER REQUEST", yellow])
    #end

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

  def do_event(tick)
    #Convert time to ticks

    events.each do |time, event|
      #puts time*60
      #puts tick
      event.call if tick == time*60
    end

  end

end