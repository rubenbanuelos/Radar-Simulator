def add_events(s)
  s.events = {
    #30   => -> {@s.aircrafts["ACA1754"].say_bearing_to(@s.waypoints["JOH"])},
    #30   => -> {@s.aircrafts["ACA1754"].say_speed},
    1   => -> {@s.spawn_aicraft(@s.lobby["RVV35"])},
    5   => -> {@s.spawn_aicraft(@s.lobby["TRP3"])},
    28  => -> {@s.aircrafts["RVV35"].assigned_altitude = 7000},
    60  => -> {@s.aircrafts["TRP3"].radar_target.squawk_ifr = true},
    61  => -> {@s.alert_ident("TRP3")},
    62  => -> {@s.aircrafts["N721SQ"].say_position},
    70  => -> {@s.aircrafts["QXE178"].assigned_waypoint = @s.waypoints["FORAT"]},
    80  => -> {@s.spawn_aicraft(@s.lobby["ACA1754"])},
    90  => -> {@s.aircrafts["ACA1754"].radar_target.in_control = true},
    91  => -> {@s.alert_handover_rcv("ACA1754")},

    395 => -> {@s.aircrafts["ACA1754"].assigned_waypoint = @s.waypoints["ANC"]},
    460 => -> {@s.aircrafts["FDX792"].assigned_waypoint = @s.waypoints["JOVOM"]}
  }
  
end