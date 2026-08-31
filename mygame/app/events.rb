def add_events(s)
  
  t = 146

  s.events["RVV35"] = {
    t + 0   => -> {@s.spawn_aicraft(@s.lobby["RVV35"])},
    t + 36  => -> {@s.aircrafts["RVV35"].assigned_altitude = 7000},
    t + 100 => -> {@s.aircrafts["RVV35"].assigned_heading = 315},
    t + 135 => -> {@s.alert_handover_snt("RVV35")},
    t + 140 => -> {@s.aircrafts["RVV35"].assigned_heading = 16},
    t + 150 => -> {@s.aircrafts["RVV35"].radar_target.in_control = false},
    t + 254 => -> {@s.aircrafts.delete("RVV55")}
  }
  
  t = 5

  s.events["TRP3"] = {
    t + 0   => -> {@s.spawn_aicraft(@s.lobby["TRP3"])},
    t + 50  => -> {@s.aircrafts["TRP3"].radar_target.squawk_ifr = true}
  }

  s.events["TRP3 Alerts"] = {
    t + 50  => -> {@s.alert_ident("TRP3")},
  }

  t = 80
  
  s.events["ACA1754"] = {
    t + 0   => -> {@s.spawn_aicraft(@s.lobby["ACA1754"])},
    t + 20  => -> {@s.aircrafts["ACA1754"].radar_target.in_control = true},
    t + 322 => -> {@s.aircrafts["ACA1754"].assigned_waypoint = @s.waypoints["SNRIS"]}
  }

  s.events["ACA1754 Alerts"] = {
    t + 20  => -> {@s.alert_handover_rcv("ACA1754")},
  }

  t = 0

  s.events["N721SQ"] = {
  }

  t = 70

  s.events["QXE178"] = {
    t + 0   => -> {@s.aircrafts["QXE178"].assigned_waypoint = @s.waypoints["FORAT"]}
  }

  t = 462

  s.events["FDX792"] = {
    t + 0   => -> {@s.aircrafts["FDX792"].assigned_waypoint = @s.waypoints["JOVOM"]}
  }

  t = 0
  s.events["AAL1151"] = {
    t + 28   => -> {@s.aircrafts["AAL1151"].assigned_altitude = 8000}
  }

end