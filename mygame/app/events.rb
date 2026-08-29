def add_events(s)
  s.events = {
    #30   => -> {@s.aircrafts["ACA1754"].say_bearing_to(@s.waypoints["JOH"])},
    #30   => -> {@s.aircrafts["ACA1754"].say_speed},
    5    => -> {@s.spawn_aicraft(@s.lobby["TRP3"])},
    30   => -> {@s.spawn_aicraft(@s.lobby["ACA1754"])},
    49   => -> {@s.aircrafts["ACA1754"].radar_target.in_control = true},
    50   => -> {@s.alert_handover_rcv("ACA1754")},
    60   => -> {@s.aircrafts["TRP3"].radar_target.squawk_ifr = true},
    61   => -> {@s.alert_ident("TRP3")}, 
    70   => -> {@s.aircrafts["QXE178"].assigned_waypoint = @s.waypoints["FORAT"]}

  }
  
end