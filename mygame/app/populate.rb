#Aircraft populator

def populate(s)


    s.add_aircraft_to_lobby("TRP3")
    s.lobby["TRP3"].altitude = 6500
    s.lobby["TRP3"].ias = 95
    s.lobby["TRP3"].type = "B06T"
    s.lobby["TRP3"].position = Position.new(202.40, 55.20)
    s.lobby["TRP3"].heading = 295
    s.lobby["TRP3"].assigned_waypoint = @s.waypoints["WGR"]
    s.lobby["TRP3"].radar_target.squawk_ifr = false

    s.add_aircraft("QXE178")
    s.aircrafts["QXE178"].altitude = 500
    s.aircrafts["QXE178"].ias = 170
    s.aircrafts["QXE178"].type = "DH8A"
    s.aircrafts["QXE178"].position = Position.new(167, 74)
    s.aircrafts["QXE178"].heading = 20
    s.aircrafts["QXE178"].assigned_altitude = 25000




    #s.aircrafts["TEST"].radar_target.emergency = true
    #s.aircrafts["TEST"].radar_target.mva = true    


end