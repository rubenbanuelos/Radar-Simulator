require_relative "target"
require_relative "vectors"
require_relative "profile_sheet"
require_relative "autopilot"
require_relative "global_params"

class Aircraft
  
  attr_accessor :autopilot, :altitude, :heading, :ias, :position, :type, :wake_category, :trk, :gspd
  attr_accessor :turn_rate, :radar_target
  attr_accessor :turn_rate, :climb_profile, :descent_profile, :top_speed, :cruise_speed, :stall_speed, :acceleration_profile, :deceleration_profile
  attr_accessor :assigned_altitude, :assigned_heading, :assigned_waypoint, :assigned_speed
  attr_accessor :ho_rcv, :ho_snt, :snt_countdown, :rcv_countdown
  attr_reader :callsign

  def initialize(callsign)
        
    #The aircraft callsign and essentially, its name
    @callsign = callsign
    #Aircraft attributes
    @type = "GENERIC" #Aircraft ICAO type ID
    @wake_category = "M"#Aircraft wake category

    #profile
    @turn_rate = 3
    @climb_profile = []
    @acceleration_profile = []
    @descent_profile = []
    @top_speed = []
    @cruise_speed = []
    @stall_speed = 0


    #Aircraft instruments (Defaults to zero)
    @altitude = 0 #Expressed in feet AMSL
    @heading = 0 #Magnetic heading
    @ias = 0 #Indicated airspeed expressed in knots
    @position = Position.new(0,0) #Aircraft location expressed in 
    #cartesian coordinates and nautical miles

    #Derived 
    @trk = 0 #Aircraft current track over the ground
    @gspd = 0 #Aircraft current groundspeed

    #Assigned flight
    @assigned_altitude  = nil
    @assigned_heading   = nil
    @assigned_waypoint  = nil
    @assigned_speed     = nil
    @autopilot = Autopilot.new(self)


    @radar_target = RadarTarget.new(@callsign)

    @ho_rcv = false
    @ho_snt = false

    @rcv_countdown = 0
    @snt_countdown = 0
  end

  def update_target
    @radar_target.type = @type
    @radar_target.cat = @wake_category
    @radar_target.alt = format("%03d",(@altitude/100))
    @radar_target.gspd = format( "%03d", @gspd)

    @radar_target.ghosts.count == 0 ? populate_ghosts : nil
    
    @radar_target.ghosts.shift
    unless @radar_target.contact_lost
      @radar_target.ghosts.push(@radar_target.loc)
    else
      @radar_target.ghosts.push(Position.new(-4,-4))
    end
    @radar_target.loc = @position.dup
    # Convert map location to pixels on screen
    @radar_target.loc.x *= GlobalParams::SCALE_FACTOR
    @radar_target.loc.y *= GlobalParams::SCALE_FACTOR
    if @assigned_altitude
      if @assigned_altitude > @altitude
        @radar_target.clrd_alt = "↗" + format("%03d",(@assigned_altitude/100))
      end
      if @assigned_altitude < @altitude
        @radar_target.clrd_alt = "↘" + format("%03d",(@assigned_altitude/100))
      end
    else
      @radar_target.clrd_alt = ""
    end
  end

  def populate_ghosts
    #extrapolate previous positions based on current speed to create initial set of ghost tracks
    reverse_heading = (@heading + 180) % 360 #Obtain heading opposite to the aircraft current movement
    step = get_cartesian_coordinates(@ias / 720, reverse_heading)

    for i in 1..5
      @radar_target.ghosts.push(
        
        Position.new(
          (@position.x + step[0]*i)*GlobalParams::SCALE_FACTOR, 
          (@position.y + step[1]*i)*GlobalParams::SCALE_FACTOR
        )
      )
    end
  end

  def receive_handover_request
    @autopilot.alert(" *HO*")
    @rcv_countdown = 9
    @ho_rcv = true
  end

  def send_handover_request
    @autopilot.alert(" *HO*")
    @snt_countdown = 9
    @ho_snt = true
  end
  
  def load_profile_sheet(type)
    
    if type == "Jet"
      climb = [
        Profile.new(4000, 5000),
        Profile.new(3000, 10000),
        Profile.new(2000, 20000),
        Profile.new(1500, 30000),
        Profile.new(1000, 100000)
      ]

      descent = [
        Profile.new(-750, 0),
        Profile.new(-1000, 5000),
        Profile.new(-1500, 10000),
        Profile.new(-2000, 20000),
        Profile.new(-3000, 30000),
        Profile.new(-4000, 100000)
      ]

      top_speed = [
        Profile.new(250, 0),
        Profile.new(250, 10000),
        Profile.new(350, 20000),
        Profile.new(300, 30000),
        Profile.new(280, 35000),
        Profile.new(250, 100000)
      ]

      cruise_speed = [
        Profile.new(250, 0),
        Profile.new(250, 10000),
        Profile.new(330, 20000),
        Profile.new(280, 30000),
        Profile.new(250, 35000),
        Profile.new(230, 100000)
      ]

      acceleration_profile = [
        Profile.new(6.0, 0),
        Profile.new(3.0, 50000),
        Profile.new(1.5, 10000),
        Profile.new(1.0, 20000),
        Profile.new(0.8, 40000)
      ]

      deceleration_profile = [
        Profile.new(-2.0, 0),
        Profile.new(-3.0, 50000),
        Profile.new(-3.0, 10000),
        Profile.new(-3.0, 20000),
        Profile.new(-3.0, 40000)
      ]

      stall_speed = 140
    end

    if type == "Helicopter"
      climb = [
        Profile.new(2000, 5000),
        Profile.new(1000, 10000),
        Profile.new(500 , 100000)
      ]

      descent = [
        Profile.new(-200,  1000),
        Profile.new(-1000, 5000),
        Profile.new(-2000, 10000),
        Profile.new(-2500, 100000)
      ]

      top_speed = [
        Profile.new(125, 0),
        Profile.new(80, 20000),
      ]

      cruise_speed = [
        Profile.new(110, 0),
        Profile.new(80, 20000)
      ]

      acceleration_profile = [
        Profile.new(6.0, 0),
        Profile.new(3.0, 50000),
        Profile.new(1.5, 20000)
      ]

      deceleration_profile = [
        Profile.new(-2.0, 0),
        Profile.new(-3.0, 50000),
        Profile.new(-3.0, 20000),
      ]

      stall_speed = 0
    end
  
    if type == "Turboprop Multi-Engine"
      climb = [
        Profile.new(2000, 5000),
        Profile.new(1500, 10000),
        Profile.new(1000, 20000),
        Profile.new(750,  30000),
        Profile.new(500,  100000)
      ]

      descent = [
        Profile.new(-750, 0),
        Profile.new(-1000, 2500),
        Profile.new(-1500, 5000),
        Profile.new(-2000, 10000),
        Profile.new(-3000, 20000),
        Profile.new(-4000, 30000)
      ]

      top_speed = [
        Profile.new(250, 0),
        Profile.new(250, 10000),
        Profile.new(220, 20000),
        Profile.new(200, 30000),
        Profile.new(180, 100000)
      ]

      cruise_speed = [
        Profile.new(240, 0),
        Profile.new(240, 10000),
        Profile.new(200, 20000),
        Profile.new(180, 30000),
        Profile.new(160, 100000)
      ]

      acceleration_profile = [
        Profile.new(5.0, 0),
        Profile.new(3.0, 50000),
        Profile.new(1.5, 10000),
        Profile.new(1.0, 20000),
        Profile.new(0.8, 35000)
      ]

      deceleration_profile = [
        Profile.new(-2.0, 0),
        Profile.new(-3.0, 50000),
        Profile.new(-3.0, 10000),
        Profile.new(-3.0, 20000),
        Profile.new(-3.0, 35000)
      ]

      stall_speed = 100
    end

    if type == "Turboprop Single-Engine"
      climb = [
        Profile.new(1800, 5000),
        Profile.new(1200, 10000),
        Profile.new(800, 20000),
        Profile.new(600,  30000),
        Profile.new(500,  100000)
      ]

      descent = [
        Profile.new(-500, 0),
        Profile.new(-1000, 2500),
        Profile.new(-1500, 5000),
        Profile.new(-2000, 10000),
        Profile.new(-2000, 20000)
      ]

      top_speed = [
        Profile.new(120, 0),
        Profile.new(100, 10000),
        Profile.new(80, 20000),
      ]

      cruise_speed = [
        Profile.new(100, 0),
        Profile.new(90, 10000),
        Profile.new(70, 20000)
      ]

      acceleration_profile = [
        Profile.new(4.0, 0),
        Profile.new(3.0, 50000),
        Profile.new(1.5, 10000),
        Profile.new(1.0, 20000)
      ]

      deceleration_profile = [
        Profile.new(-2.0, 0),
        Profile.new(-3.0, 50000),
        Profile.new(-3.0, 10000),
        Profile.new(-3.0, 20000)
      ]

      stall_speed = 50
    end

    if type == "Piston Single-Engine"
      climb = [
        Profile.new(1500, 5000),
        Profile.new(1000, 10000),
        Profile.new(750, 20000),
        Profile.new(500,  30000),
        Profile.new(300,  100000)
      ]

      descent = [
        Profile.new(-500, 0),
        Profile.new(-1000, 2500),
        Profile.new(-1500, 5000),
        Profile.new(-2000, 10000),
        Profile.new(-2000, 20000)
      ]

      top_speed = [
        Profile.new(100, 0),
        Profile.new(80, 10000),
        Profile.new(60, 20000),
      ]

      cruise_speed = [
        Profile.new(85, 0),
        Profile.new(70, 10000),
        Profile.new(65, 20000)
      ]

      acceleration_profile = [
        Profile.new(4.0, 0),
        Profile.new(3.0, 50000),
        Profile.new(1.5, 10000),
        Profile.new(1.0, 20000)
      ]

      deceleration_profile = [
        Profile.new(-2.0, 0),
        Profile.new(-3.0, 50000),
        Profile.new(-3.0, 10000),
        Profile.new(-3.0, 20000)
      ]

      stall_speed = 50
    end

    @climb_profile = climb
    @descent_profile = descent
    @top_speed = top_speed
    @cruise_speed = cruise_speed
    @stall_speed = stall_speed
    @acceleration_profile = acceleration_profile
    @deceleration_profile = deceleration_profile

  end

end


