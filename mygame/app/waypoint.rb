require_relative "vectors"

Waypoint = Struct.new(
  :name,
  :position
)

def parse_waypoints
  data = DR.parse_json(File.read("data/waypoints.json"))
  wp = {}


  data.each do |id, waypoint|
    wp[id] = Waypoint.new(waypoint[0],Position.new(waypoint[1][0],waypoint[1][1]))
  end

  return wp

end