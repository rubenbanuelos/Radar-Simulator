#Aircraft populator

def populate(s)


    s.add_aircraft("TRP3")
    s.aircrafts["TRP3"].altitude = 6500
    s.aircrafts["TRP3"].ias = 95
    s.aircrafts["TRP3"].type = "B06T"
    s.aircrafts["TRP3"].position = Position.new(202.40, 35.20)
    s.aircrafts["TRP3"].heading = 322
    s.aircrafts["TRP3"].assigned_altitude = 6500
    s.aircrafts["TRP3"].assigned_waypoint = @s.waypoints["WGR"]
    s.aircrafts["TRP3"].radar_target.squawk_ifr = false




    #s.aircrafts["TEST"].radar_target.emergency = true
    #s.aircrafts["TEST"].radar_target.mva = true    

    #@s.alerts["Hola"] = Alert.new(@s.aircrafts["TEST"], "Sent Handover")

end