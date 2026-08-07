require_relative "../tools/vectors"
require_relative "../tools/interpolator"
require_relative "../tools/global_params"
require_relative "../world/weather"

class Autopilot
  #Here is where the logic that controls the aircraft lives
  def initialize(aircraft)
    @aircraft = aircraft
    @target_altitude = 0
    @target_heading = 0
    @target_speed = 0
    @target_track = 0
  end

  def fly(weather)
    #Calculate groundspeed and track and update data for aircraft
    
    #Compute true airspeed
    tas = calculate_tas(weather, @aircraft.altitude, @aircraft.ias)
    
    vtas = get_cartesian_coordinates(tas, @aircraft.heading)

    tas_x = vtas[0]
    tas_y = vtas[1]

    wind = interpolate_wind(weather, @aircraft.altitude)
    wind_speed = get_cartesian_coordinates(wind.speed, wind.heading) 

    gspd_x = tas_x + wind_speed[0]
    gspd_y = tas_y + wind_speed[1]

    vgspd = get_polar_coordinates(gspd_x, gspd_y)

    @aircraft.gspd = vgspd[0]
    @aircraft.trk = (vgspd[1] + 360) % 360

    #COMPUTE AIRCRAFT NEW POSITION

    @aircraft.position.x += gspd_x/3600
    @aircraft.position.y += gspd_y/3600

    #Check if there are assigned values
    @target_altitude = @aircraft.assigned_altitude ? 
      @aircraft.assigned_altitude : 
      @aircraft.altitude
    
    @target_speed = @aircraft.assigned_speed ? 
      [@aircraft.assigned_speed,interpolator(@aircraft.top_speed,@aircraft.altitude)].min : #Target speed has to be below redline
      interpolator(@aircraft.cruise_speed, @aircraft.altitude) #Select best cruise speed at altitude

    @target_speed = @aircraft.stall_speed > @target_speed ? @aircraft.stall_speed : @target_speed 

    @target_heading = @aircraft.assigned_heading ? 
      @aircraft.assigned_heading : 
      @aircraft.heading 

    @aircraft.altitude = change_altitude
    @aircraft.ias = change_speed
    @aircraft.heading = change_heading

  end

  def get_control_input(delta, change_rate)
    #This function determines the degree of control input
    return delta.abs > change_rate.abs ?  change_rate : delta
  end

  def change_altitude
    #get delta
    delta = @target_altitude - @aircraft.altitude
    
    #Aircraft is at target altitude
    if delta == 0
      @aircraft.assigned_altitude = nil
      return @aircraft.altitude
    end

    #Determine climb or descent regime
    if delta > 0 #CLIMB
      rate = interpolator(@aircraft.climb_profile, @aircraft.altitude) / 60
      return @aircraft.altitude + get_control_input(delta, rate)
    end
    if delta < 0 #DESCENT
      rate = interpolator(@aircraft.descent_profile, @aircraft.altitude) / 60
      return @aircraft.altitude + get_control_input(delta, rate)
    end

  end

  def change_speed
    #get delta
    delta = @target_speed - @aircraft.ias
    
    #Aircraft is at target speed
    if delta == 0
      @aircraft.assigned_speed = nil
      return @aircraft.ias
    end

    #Determine acceleration or deceleration regime
    if delta > 0 #ACCELERATE
      rate = interpolator(@aircraft.acceleration_profile, @aircraft.ias)
      return @aircraft.ias + get_control_input(delta, rate)
    end
    if delta < 0 #DECELERATE
      rate = interpolator(@aircraft.deceleration_profile, @aircraft.ias)
      return @aircraft.ias + get_control_input(delta, rate)
    end

  end

  def change_heading
    #THIS IS THE MOST COMPLEX
    #Check if there's an assigned waypoint
    if @aircraft.assigned_waypoint
      #Calculate track to waypoint
      distance_vector_x = @aircraft.assigned_waypoint.position.x - @aircraft.position.x
      distance_vector_y = @aircraft.assigned_waypoint.position.y - @aircraft.position.y
      
      p = get_polar_coordinates(distance_vector_x, distance_vector_y)
      distance = p[0]
      track    = p[1] 

      if distance < 1 #Aircraft is close to waypoint, remove waypoint and maintain heading
        @target_heading = @aircraft.heading
        @aircraft.assigned_waypoint = nil
        return @aircraft.heading
      else
        delta = get_heading_difference(@aircraft.trk, track)
        if delta > 0 
          a = (@aircraft.heading + get_control_input(delta, @aircraft.turn_rate) + 360)%360
          return a 
        else
          a = (@aircraft.heading + get_control_input(delta, -@aircraft.turn_rate) + 360)%360
          return a
        end
      end

    else

      if @aircraft.heading == @target_heading
        return @aircraft.heading
      end

      delta = get_heading_difference(@aircraft.heading, @target_heading)
      
      if delta > 0 
        a = (@aircraft.heading + get_control_input(delta, @aircraft.turn_rate) + 360)%360
        return a
      else
        a = (@aircraft.heading + get_control_input(delta, -@aircraft.turn_rate) + 360)%360
        return a
      end
        
    end

  end

end

