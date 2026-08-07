require_relative "../radar/target"
require_relative "../tools/vectors"
require_relative "../tools/profile_sheet"
require_relative "autopilot"

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

    @radar_target = RadarTarget.new(@callsign, @type, @wake_category)  
  end

  def update_target
    @radar_target.alt = format("%03d",(@altitude/100))
    @radar_target.gspd = format( "%03d", @gspd)
  end

  def load_profile_sheet
  end

end


