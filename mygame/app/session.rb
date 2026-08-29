require_relative 'aircraft'
require_relative 'waypoint'
require_relative 'weather'
require_relative 'draw'

class Session
  #Class containing a radar session
  attr_accessor :aircrafts, :waypoints, :weather, :sector, :time, :tz, :events,:freq, :lobby, :time_diff, :alerts
  
  def initialize
    @aircrafts = {}
    @waypoints = {}
    @events    = {}
    @lobby     = {}
    @alerts    = {}
    @weather   = Weather.new
    @sector    = ""
    @freq      = ""
    @time      = Time.new
    @tz        = ""
    @time_diff = 0
  end

  def add_aircraft(callsign)
    @aircrafts[callsign] = Aircraft.new(callsign)
  end

  def add_aircraft_to_lobby(callsign)
    @lobby[callsign] = Aircraft.new(callsign)
  end

  def begin_session args
    
    @aircrafts.each_value do |aircraft| #draws aircrafts in initial positions
      aircraft.update_target
    end
  end

  def refresh_screen args
    draw_timer args
    
    gray = [160,160,160,255]
    red = [255,0,0,255]
    yellow = [255,255,0,255]

    status = []
    status.push([@sector,gray])
    status.push([@freq,  gray])
    
    t_local = format("%02d", @time.hour ).to_s + ":" + format("%02d", @time.min) + ":" + format("%02d", @time.sec)
    t_utc = format("%02d", (@time.hour - time_diff) % 24).to_s + ":" + format("%02d", @time.min) + ":" + format("%02d", @time.sec)
    
    status.push([t_local + " " + @tz + " " + t_utc + " UTC", gray])

    if (@aircrafts.any? {|_, aircraft| aircraft.radar_target.emergency})
      status.push(["**ACTIVE EMERGENCY**", red])
    end


    if (@aircrafts.any? {|_, aircraft| aircraft.radar_target.mva})
      status.push(["**VECTORING ALTITUDE**", red])
    end

    @alerts.each_value do |alert|
      status.push([alert.text,alert.color])
    end

    draw_status(args, status)
    draw_background args #Draws background
     
    @aircrafts.each_value do |aircraft| #draws aircrafts in initial positions

      draw_target(args, aircraft.radar_target) #draw targets and ghosts
      
      if aircraft.radar_target.squawk_ifr
        draw_tag(args, aircraft.radar_target) #draw tags for aircraft in control
      end
    end


  end

  def step

    #Advance one second of simulation with aircraft
    @aircrafts.each_value do |aircraft|
      aircraft.autopilot.fly(weather)
    end

    #Move active alerts forward
    @alerts.each do |key, alert|
      alert.update
      if alert.finished
        @alerts.delete(key)
      end
    end

    @time += 1 #Update time

  end


  def update args
    @aircrafts.each_value do |aircraft|
      angle = ((aircraft.sweep_angle * 150/Math::PI).round + 300) % 300
      slice = args.state.timer % 300
      if angle == slice
        aircraft.update_target
      end
    end
  end

  def do_event(tick)
    #Convert time to ticks

    events.each do |time, event|
      event.call if tick == time*60
    end

  end

  def spawn_aicraft(aircraft)
    aircraft.update_target
    @aircrafts[aircraft.callsign] = aircraft
  end

  def alert_ident(callsign)
    @alerts[callsign] = Alert.new(@aircrafts[callsign], "Ident")
  end

  def alert_handover_rcv(callsign)
    @alerts[callsign] = Alert.new(@aircrafts[callsign], "Receive Handover")
  end

  def alert_handover_snt(callsign)
    @alerts[callsign] = Alert.new(@aircrafts[callsign], "Sent Handover")
  end

end