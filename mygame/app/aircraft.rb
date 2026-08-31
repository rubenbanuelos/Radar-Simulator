require_relative "target"
require_relative "vectors"
require_relative "profile_sheet"
require_relative "autopilot"
require_relative "global_params"

class Aircraft
  
  attr_accessor :autopilot, :altitude, :heading, :ias, :position, :type, :wake_category, :trk, :gspd
  attr_accessor :turn_rate, :radar_target, :updated
  attr_accessor :turn_rate, :climb_profile, :descent_profile, :top_speed, :cruise_speed, :stall_speed, :acceleration_profile, :deceleration_profile, :ceiling, :climb_speed, :descent_speed
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
    @ceiling = 50000


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
    @updated = false #this flag is used to check if the aircraft has already been updated during a single radar sweep and prevents a single aircraft from being updated multiple times.
  end

  def update_target
    @updated = true
    @radar_target.type = @type
    @radar_target.cat = @wake_category
    @radar_target.alt = format("%03d",(@altitude/100))
    @radar_target.gspd = format( "%03d", @gspd)

    @radar_target.ghosts.count == 0 ? populate_ghosts : nil
    
    @radar_target.ghosts.shift
    unless @radar_target.contact_lost
      @radar_target.ghosts.push(@radar_target.loc)
    else
      @radar_target.ghosts.push(Position.new(-20,-20))
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

    for i in 1..5
      @radar_target.ghosts.push(
        Position.new(
          @position.x * GlobalParams::SCALE_FACTOR, 
          @position.y * GlobalParams::SCALE_FACTOR
        )
      )
    end
  end

  def type=(model)
    #Custom setter to fetch aircraft class and profile sheet from catalog

    @type = model
    profiles = parse_profiles
    catalog = parse_catalog
    load_profile_sheet(profiles[catalog[model]["type"]])
    @wake_category = catalog[model]["category"]
  end

  def sweep_angle
    return Math::atan2(
        GlobalParams::MAP_CENTER_X - @radar_target.loc.x,
        GlobalParams::MAP_CENTER_Y - @radar_target.loc.y)
  end

  
  def load_profile_sheet(sheet)
    
    @climb_profile = sheet.climb_rate
    @descent_profile = sheet.descent_rate
    @top_speed = sheet.top_speed
    @cruise_speed = sheet.cruise_speed
    @climb_speed = sheet.climb_speed
    @descent_speed = sheet.descent_speed
    @stall_speed = sheet.stall_speed
    @ceieling = sheet.ceiling
    @acceleration_profile = sheet.acceleration
    @deceleration_profile = sheet.deceleration
    @stall_speed = sheet.stall_speed
    @ceiling = sheet.ceiling
    @turn_rate = sheet.turn_rate

  end

  def say_position
    puts @position.x
    puts @position.y
  end

  def say_speed
    puts @ias
  end

  def say_heading
    puts @heading
  end

  def say_distance_to(wp)
    
    dx = wp.position.x - @position.x
    dy = wp.position.y - @position.y

    puts get_polar_coordinates(dx,dy)[0]
  end

  def say_bearing_to(wp)
    dx = wp.position.x - @position.x
    dy = wp.position.y - @position.y

    puts (get_polar_coordinates(dx,dy)[1] + 360) % 360 
  end



end


