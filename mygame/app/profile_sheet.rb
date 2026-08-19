#Used to store performance sheets for specific types of aircraft
require_relative 'vectors'


ProfileSheet = Struct.new(
  :turn_rate,
  :climb_rate,
  :descent_rate,
  :top_speed,
  :climb_speed,
  :descent_speed,
  :cruise_speed,
  :stall_speed,
  :ceiling,
  :acceleration,
  :deceleration
)

def convert_to_profiles(hash)
  #Takes a hash from a json and convert it to a profile
  out = []
  hash.each do |altitude, data|
    out.push(Profile.new(altitude.to_i, data.to_f))
  end
  return out
end

def parse_profiles
  flight_profiles = {}

  data = DR.parse_json(File.read('data/profiles.json'))
  #puts data
  data.each do |aircraft, sheet|
    aircraft_sheet = ProfileSheet.new()
    
    aircraft_sheet.climb_rate    = convert_to_profiles(sheet["Climb Rate"]   )
    aircraft_sheet.descent_rate  = convert_to_profiles(sheet["Descent Rate"] )
    aircraft_sheet.cruise_speed  = convert_to_profiles(sheet["Cruise Speed"] )
    aircraft_sheet.climb_speed   = convert_to_profiles(sheet["Climb Speed"]  )
    aircraft_sheet.descent_speed = convert_to_profiles(sheet["Descent Speed"])
    aircraft_sheet.top_speed     = convert_to_profiles(sheet["Top Speed"]    )
    aircraft_sheet.acceleration  = convert_to_profiles(sheet["Acceleration"] )
    aircraft_sheet.deceleration  = convert_to_profiles(sheet["Deceleration"] )
    aircraft_sheet.ceiling       = sheet["Ceiling"] 
    aircraft_sheet.stall_speed   = sheet["Stall Speed"]
    aircraft_sheet.turn_rate     = sheet["Turn Rate"]

    flight_profiles[aircraft] = aircraft_sheet
  end

  return flight_profiles

end