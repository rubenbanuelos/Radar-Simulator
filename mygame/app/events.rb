def add_events(s)

  t = 230

  s.events["NRA11"] = {
    t + 0   => -> {s.aircrafts["NRA11"].radar_target.squawk_ifr = false},
    t + 1   => -> {s.aircrafts["NRA11"].assigned_altitude = 1000},
    t + 20  => -> {s.aircrafts["NRA11"].assigned_speed = 100},
    t + 20  => -> {s.aircrafts["NRA11"].assigned_waypoint = nil},
    t + 115 => -> {s.aircrafts["NRA11"].assigned_heading = 40},
    t + 140 => -> {s.aircrafts["NRA11"].assigned_heading = 130},
    t + 160 => -> {s.aircrafts["NRA11"].assigned_altitude = 800},
    t + 200 => -> {s.aircrafts["NRA11"].assigned_altitude = 0},
    t + 201 => -> {s.aircrafts["NRA11"].assigned_speed = 0},
    t + 350 => -> {s.aircrafts.delete("NRA11")}
  }
  
  t = 1

  s.events["DAL1285"] = {
    t + 0   => -> {s.spawn_aicraft(s.lobby["DAL1285"])},
    t + 584 => -> {s.aircrafts["DAL1285"].assigned_waypoint(s.waypoints["SNRIS"])},
    t + 585 => -> {s.aircrafts["DAL1285"].assigned_altitude = 20000},
  }

  s.events["DAL1285 Alerts"] = {
    t + 66 => -> {s.alert_handover_rcv("DAL1285")}
  }
  
  t = 194

  s.events["RVV35"] = {
    t + 0   => -> {s.spawn_aicraft(@s.lobby["RVV35"])},
    t + 36  => -> {s.aircrafts["RVV35"].assigned_altitude = 9000},
    t + 126 => -> {s.aircrafts["RVV35"].assigned_heading = 315},
    t + 150 => -> {s.alert_handover_snt("RVV35")},
    t + 159 => -> {s.aircrafts["RVV35"].radar_target.in_control = false},
    t + 175 => -> {s.aircrafts["RVV35"].assigned_heading = 16},
    t + 278 => -> {s.aircrafts.delete("RVV55")}
  }
  
  t = 5

  s.events["TRP3"] = {
    t + 0   => -> {s.spawn_aicraft(@s.lobby["TRP3"])},
    t + 50  => -> {s.aircrafts["TRP3"].radar_target.squawk_ifr = true},
    t + 344 => -> {s.aircrafts["TRP3"].radar_target.emergency = true},
    t + 435 => -> {s.aircrafts["TRP3"].radar_target.mva = true},
  }

  s.events["TRP3 Alerts"] = {
    t + 50  => -> {s.alert_ident("TRP3")},
  }

  t = 70
  
  s.events["ACA1754"] = {
    t + 0   => -> {s.spawn_aicraft(s.lobby["ACA1754"])},
    t + 20  => -> {s.aircrafts["ACA1754"].radar_target.in_control = true},
    t + 322 => -> {s.aircrafts["ACA1754"].assigned_waypoint = s.waypoints["SNRIS"]},
    t + 343 => -> {s.aircrafts["ACA1754"].assigned_altitude = 20000}
  }

  s.events["ACA1754 Alerts"] = {
    t + 20  => -> {s.alert_handover_rcv("ACA1754")},
  }

  t = 517

  s.events["N721SQ"] = {
    t + 0   => -> {s.alert_handover_snt("N721SQ")},
    t + 9   => -> {s.aircrafts["N721SQ"].radar_target.in_control = false},
  }

  t = 70

  s.events["QXE178"] = {
    t + 0   => -> {s.aircrafts["QXE178"].assigned_waypoint = s.waypoints["FORAT"]},
    t + 530 => -> {s.aircrafts["QXE178"].assigned_waypoint = s.waypoints["JOVOM"]}
  }

  t = 462

  s.events["FDX792"] = {
    t + 0   => -> {s.aircrafts["FDX792"].assigned_waypoint = s.waypoints["JOVOM"]}
  }

  t = 28
  s.events["AAL1151"] = {
    t + 0   => -> {s.aircrafts["AAL1151"].assigned_altitude = 35000},
    t + 75  => -> {s.aircrafts["AAL1151"].assigned_heading = 180},
    t + 165 => -> {s.aircrafts["AAL1151"].assigned_waypoint = s.waypoints["SNRIS"]},
    t + 337 => -> {s.aircrafts["AAL1151"].radar_target.in_control = true},
    t + 345 => -> {s.aircrafts["AAL1151"].assigned_waypoint = s.waypoints["JOH"]}
  }
  
  s.events["AAL1151 Alerts"] = {
    t + 337 => -> {s.alert_handover_rcv("AAL1151")}
  }
  
  t = 112
  
  s.events["ASA291"] = {
    t + 0   => -> {s.alert_handover_snt("ASA291")},
    t + 9   => -> {s.aircrafts["ASA291"].radar_target.in_control = false},
    t + 38  => -> {s.aircrafts["ASA291"].assigned_waypoint = @s.waypoints["ANC"]},
    t + 53  => -> {s.aircrafts["ASA291"].assigned_altitude = 6000},
    t + 137 => -> {s.aircrafts["ASA291"].assigned_waypoint = nil},
    t + 138 => -> {s.aircrafts["ASA291"].assigned_heading = 280},
    t + 320 => -> {s.aircrafts["ASA291"].assigned_altitude = 4000},
    t + 480 => -> {s.aircrafts["ASA291"].assigned_waypoint = @s.waypoints["5MRWY07"]},
  }

  t = 320

  s.events["TPR3 Emergency alt"] = {
    t + 0   => -> {s.aircrafts["TRP3"].altitude = 6200},
    t + 5   => -> {s.aircrafts["TRP3"].altitude = 6100},
    t + 5   => -> {s.aircrafts["TRP3"].altitude = 5900},
    t + 10  => -> {s.aircrafts["TRP3"].altitude = 5800},
    t + 20  => -> {s.aircrafts["TRP3"].altitude = 6000},
    t + 25  => -> {s.aircrafts["TRP3"].altitude = 6100},
    t + 30  => -> {s.aircrafts["TRP3"].altitude = 6200},
    t + 35  => -> {s.aircrafts["TRP3"].altitude = 5900},
    t + 40  => -> {s.aircrafts["TRP3"].altitude = 5700},
    t + 45  => -> {s.aircrafts["TRP3"].altitude = 5400},
    t + 50  => -> {s.aircrafts["TRP3"].altitude = 5500},
    t + 60  => -> {s.aircrafts["TRP3"].altitude = 5600},
    t + 65  => -> {s.aircrafts["TRP3"].altitude = 5500},
    t + 75  => -> {s.aircrafts["TRP3"].altitude = 5600},
    t + 85  => -> {s.aircrafts["TRP3"].altitude = 5700},
    t + 90  => -> {s.aircrafts["TRP3"].altitude = 5600},
    t + 95  => -> {s.aircrafts["TRP3"].altitude = 5700},
    t + 100 => -> {s.aircrafts["TRP3"].altitude = 5500},
    t + 105 => -> {s.aircrafts["TRP3"].altitude = 5300},
    t + 110 => -> {s.aircrafts["TRP3"].altitude = 5000},
    t + 115 => -> {s.aircrafts["TRP3"].altitude = 4800},
    t + 120 => -> {s.aircrafts["TRP3"].altitude = 4700},
    t + 125 => -> {s.aircrafts["TRP3"].altitude = 4600},
    t + 130 => -> {s.aircrafts["TRP3"].altitude = 4500},
    t + 135 => -> {s.aircrafts["TRP3"].altitude = 4400},
    t + 140 => -> {s.aircrafts["TRP3"].altitude = 4200},
    t + 145 => -> {s.aircrafts["TRP3"].altitude = 4100},
    t + 150 => -> {s.aircrafts["TRP3"].altitude = 4000},
    t + 155 => -> {s.aircrafts["TRP3"].altitude = 3900},
    t + 160 => -> {s.aircrafts["TRP3"].altitude = 3800},
    t + 165 => -> {s.aircrafts["TRP3"].altitude = 3700},
    t + 170 => -> {s.aircrafts["TRP3"].altitude = 3600},
    t + 175 => -> {s.aircrafts["TRP3"].altitude = 3500},
    t + 180 => -> {s.aircrafts["TRP3"].altitude = 3400},
    t + 185 => -> {s.aircrafts["TRP3"].radar_target.contact_lost = true},
    t + 195 => -> {s.aircrafts["TRP3"].radar_target.contact_lost_stage_2 = true},
    t + 200 => -> {s.aircrafts.delete("TRP3")}
  }

  s.events["TPR3 Emergency spd"] = {
    t + 0  => -> {s.aircrafts["TRP3"].ias = 110},
    t + 5  => -> {s.aircrafts["TRP3"].ias = 115},
    t + 5  => -> {s.aircrafts["TRP3"].ias = 120},
    t + 10 => -> {s.aircrafts["TRP3"].ias = 125},
  }

  s.events["TPR3 Emergency hdg"] = {
    t + 0   => -> {s.aircrafts["TRP3"].assigned_waypoint = nil},
    t + 5   => -> {s.aircrafts["TRP3"].heading = 225},
    t + 10  => -> {s.aircrafts["TRP3"].heading = 180},
    t + 20  => -> {s.aircrafts["TRP3"].heading = 315},
    t + 55  => -> {s.aircrafts["TRP3"].heading = 300},
    t + 75  => -> {s.aircrafts["TRP3"].heading = 275},
    t + 100 => -> {s.aircrafts["TRP3"].heading = 245},
    t + 105 => -> {s.aircrafts["TRP3"].heading = 225},
    t + 110 => -> {s.aircrafts["TRP3"].heading = 200},
    t + 115 => -> {s.aircrafts["TRP3"].heading = 180},
  }


end