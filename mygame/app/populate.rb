#Aircraft populator

def populate(s)

    #Aircrafts in lobby
    s.add_aircraft_to_lobby("TRP3")
    s.lobby["TRP3"].altitude = 6500
    s.lobby["TRP3"].ias = 95
    s.lobby["TRP3"].type = "B06T"
    s.lobby["TRP3"].position = Position.new(202.40, 47.20)
    s.lobby["TRP3"].heading = 295
    s.lobby["TRP3"].assigned_waypoint = @s.waypoints["WGR"]
    s.lobby["TRP3"].radar_target.squawk_ifr = false
    s.lobby["TRP3"].radar_target.tag_position = "TR"

    s.add_aircraft_to_lobby("ACA1754")
    s.lobby["ACA1754"].altitude = 36000
    s.lobby["ACA1754"].ias = 288
    s.lobby["ACA1754"].type = "A321"
    s.lobby["ACA1754"].position = Position.new(131.52, 117.24)
    s.lobby["ACA1754"].heading = 196
    s.lobby["ACA1754"].assigned_waypoint = @s.waypoints["JOH"]
    s.lobby["ACA1754"].radar_target.in_control = false
    s.lobby["ACA1754"].radar_target.tag_position = "TL"

    s.add_aircraft_to_lobby("RVV35")
    s.lobby["RVV35"].altitude = 128
    s.lobby["RVV35"].ias = 0
    s.lobby["RVV35"].type = "BE20"
    s.lobby["RVV35"].position = s.waypoints["PAVD"].position
    s.lobby["RVV35"].heading = 60

    #Aircrafts on radar screen
    s.add_aircraft("QXE178")
    s.aircrafts["QXE178"].altitude = 500
    s.aircrafts["QXE178"].ias = 170
    s.aircrafts["QXE178"].type = "DH8A"
    s.aircrafts["QXE178"].position = Position.new(167, 74)
    s.aircrafts["QXE178"].heading = 20
    s.aircrafts["QXE178"].assigned_altitude = 25000

    s.add_aircraft("N721SQ")
    s.aircrafts["N721SQ"].altitude = 37000
    s.aircrafts["N721SQ"].ias = 284
    s.aircrafts["N721SQ"].type = "C550"
    s.aircrafts["N721SQ"].position = Position.new(115.73, 62.82)
    s.aircrafts["N721SQ"].heading = 105
    s.aircrafts["N721SQ"].assigned_waypoint = @s.waypoints["JOVOM"]
    s.aircrafts["N721SQ"].radar_target.tag_position = "BL"

    s.add_aircraft("FDX792")
    s.aircrafts["FDX792"].altitude = 37000
    s.aircrafts["FDX792"].ias = 284
    s.aircrafts["FDX792"].type = "B77L"
    s.aircrafts["FDX792"].position = Position.new(44.01, 43.17)
    s.aircrafts["FDX792"].heading = 74
    s.aircrafts["FDX792"].assigned_waypoint = @s.waypoints["JOH"]
    s.aircrafts["FDX792"].radar_target.tag_position = "BL"

    
    #s.aircrafts["TEST"].radar_target.emergency = true
    #s.aircrafts["TEST"].radar_target.mva = true    


end