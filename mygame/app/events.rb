def add_events(s)
  
  t = 194

  s.events["RVV35"] = {
    t + 0   => -> {@s.spawn_aicraft(@s.lobby["RVV35"])},
    t + 36  => -> {@s.aircrafts["RVV35"].assigned_altitude = 9000},
    t + 126 => -> {@s.aircrafts["RVV35"].assigned_heading = 315},
    t + 150 => -> {@s.alert_handover_snt("RVV35")},
    t + 159 => -> {@s.aircrafts["RVV35"].radar_target.in_control = false},
    t + 175 => -> {@s.aircrafts["RVV35"].assigned_heading = 16},
    t + 278 => -> {@s.aircrafts.delete("RVV55")}
  }
  
  t = 5

  s.events["TRP3"] = {
    t + 0   => -> {@s.spawn_aicraft(@s.lobby["TRP3"])},
    t + 50  => -> {@s.aircrafts["TRP3"].radar_target.squawk_ifr = true}
  }

  s.events["TRP3 Alerts"] = {
    t + 50  => -> {@s.alert_ident("TRP3")},
  }

  t = 70
  
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

  t = 28
  s.events["AAL1151"] = {
    t + 0   => -> {@s.aircrafts["AAL1151"].assigned_altitude = 35000},
    t + 75  => -> {@s.aircrafts["AAL1151"].assigned_heading = 180},
    t + 165 => -> {@s.aircrafts["AAL1151"].assigned_waypoint = @s.waypoints["SNRIS"]},
    t + 337 => -> {@s.aircrafts["AAL1151"].radar_target.in_control = true},
    t + 345 => -> {@s.aircrafts["AAL1151"].assigned_waypoint = @s.waypoints["JOH"]}
  }
  
  s.events["AAL1151 Alerts"] = {
    t + 337 => -> {@s.alert_handover_rcv("AAL1151")}
  }

  t = 0
  
  s.events["ASA291"] = {
    112 => -> {@s.alert_handover_snt("ASA291")},
    121 => -> {@s.aircrafts["ASA291"].radar_target.in_control = false},
    150 => -> {@s.aircrafts["ASA291"].assigned_waypoint = @s.waypoints["ANC"]},
    165 => -> {@s.aircrafts["ASA291"].assigned_altitude = 6000},
    249 => -> {@s.aircrafts["ASA291"].assigned_waypoint = nil},
    250 => -> {@s.aircrafts["ASA291"].assigned_heading = 280}
  }

end