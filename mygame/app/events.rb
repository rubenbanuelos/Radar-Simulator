def add_events(s)
  s.events = {
    60  => -> {@s.aircrafts["TRP3"].radar_target.squawk_ifr = true},
    61  => -> {@s.alert_ident("TRP3")}
  }
  
end