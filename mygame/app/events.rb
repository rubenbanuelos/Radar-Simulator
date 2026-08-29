def add_events(s)
  s.events = {
    10 => -> {@s.aircrafts["TRP3"].say_bearing_to(@s.waypoints["WGR"])}
  }
  
end