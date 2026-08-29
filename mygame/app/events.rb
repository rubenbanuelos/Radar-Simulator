def add_events(s)
  s.events = {
    5   => -> {@s.spawn_aicraft(@s.lobby["TRP3"])},
    60  => -> {@s.aircrafts["TRP3"].radar_target.squawk_ifr = true},
    61  => -> {@s.alert_ident("TRP3")}, 
    70  => -> {@s.aircrafts["QXE178"].assigned_heading = 90}
  }
  
end