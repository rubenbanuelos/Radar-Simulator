require_relative "../radar/target"
require_relative "../tools/vectors"
require_relative "../tools/profile_sheet"
require_relative "autopilot"
require_relative "../tools/global_params"

class Aircraft
  
  attr_accessor :autopilot, :altitude, :heading, :ias, :position, :type, :wake_category, :trk, :gspd
  attr_accessor :turn_rate, :radar_target
  attr_accessor :turn_rate, :climb_profile, :descent_profile, :top_speed, :cruise_speed, :stall_speed, :acceleration_profile, :deceleration_profile
  attr_accessor :assigned_altitude, :assigned_heading, :assigned_waypoint, :assigned_speed
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
  end

  def update_target
    @radar_target.type = @type
    @radar_target.cat = @wake_category
    @radar_target.alt = format("%03d",(@altitude/100))
    @radar_target.gspd = format( "%03d", @gspd)

    @radar_target.ghosts.count == 0 ? populate_ghosts : nil
    
    @radar_target.ghosts.shift
    @radar_target.ghosts.push(@radar_target.loc)
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
    end
  end

  def populate_ghosts
    #extrapolate previous positions based on current speed to create initial set of ghost tracks
    reverse_heading = (@heading + 180) % 360 #Obtain heading opposite to the aircraft current movement
    step = get_cartesian_coordinates(@gspd / 720, reverse_heading)


    for i in 1..5
      @radar_target.ghosts.push(Position.new(@position.x + step[0]*i, @position.y + step[1]*i))
    end
  end
  
  def load_profile_sheet
  end

end


