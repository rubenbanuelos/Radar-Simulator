#Check how the aircraft works
require_relative "../app/aircraft/aircraft"
require_relative "../app/tools/interpolator"
require_relative "../app/world/waypoint"
require_relative "../app/world/weather"

#Create weather pattern
winds = [
  Profile.new(Wind.new(5.0, 70.0), 0),
  Profile.new(Wind.new(12.0, 120.0), 1000),
  Profile.new(Wind.new(18.0, 170.0), 5000),
  Profile.new(Wind.new(25.0, 225.0), 10000),
  Profile.new(Wind.new(38.0, 190.0), 25000),
  Profile.new(Wind.new(55.0 ,155.0), 45000)
]

temperatures = [
  Profile.new(10.0, 0),
  Profile.new(0.0, 3000),
  Profile.new(-10.0,10000),
  Profile.new(-20.0, 20000),
  Profile.new(-40.0, 50000)
]

weather = Weather.new
weather.altimeter = 29.72
weather.wind_layers = winds
weather.temperature_layers = temperatures


#Let's create an aircraft to test aircraft behavior

learjet = Aircraft.new("XA-EGC")
learjet.type = "LJ45"
learjet.wake_category = "L"
learjet.altitude = 35000
learjet.heading = 2
learjet.ias = 250

puts "Este es un avion"
puts learjet.type
puts "Con matricula"
puts learjet.callsign
puts "volando a " + learjet.altitude.to_s + " pies con un rumbo de " + learjet.heading.to_s + " grados y una velocidad indicada de " + learjet.ias.to_s + " nudos"


#Definiendo una matriz de Profile

climb = [
  Profile.new(0, 5000),
  Profile.new(3000, 10000),
  Profile.new(2000, 20000),
  Profile.new(1500, 30000),
  Profile.new(1000, 100000)
]

descent = [
  Profile.new(-750, 0),
  Profile.new(-1000, 5000),
  Profile.new(-1500, 10000),
  Profile.new(-2000, 20000),
  Profile.new(-3000, 30000),
  Profile.new(-4000, 100000)
]

top_speed = [
  Profile.new(250, 0),
  Profile.new(250, 10000),
  Profile.new(350, 20000),
  Profile.new(300, 30000),
  Profile.new(280, 35000),
  Profile.new(250, 100000)
]

cruise_speed = [
  Profile.new(250, 0),
  Profile.new(250, 10000),
  Profile.new(330, 20000),
  Profile.new(280, 30000),
  Profile.new(250, 35000),
  Profile.new(230, 100000)
]

acceleration_profile = [
  Profile.new(6.0, 0),
  Profile.new(3.0, 50000),
  Profile.new(1.5, 10000),
  Profile.new(1.0, 20000),
  Profile.new(0.8, 35000)
]

deceleration_profile = [
  Profile.new(-2.0, 0),
  Profile.new(-3.0, 50000),
  Profile.new(-3.0, 10000),
  Profile.new(-3.0, 20000),
  Profile.new(-3.0, 35000)
]

stall_speed = 140

learjet.climb_profile = climb
learjet.descent_profile = descent
learjet.top_speed = top_speed
learjet.cruise_speed = cruise_speed
learjet.stall_speed = stall_speed
learjet.acceleration_profile = acceleration_profile
learjet.deceleration_profile = deceleration_profile



puts "Valores de profile Asignados"

puts interpolator(top_speed, 500)

learjet.assigned_altitude = 2000
learjet.autopilot.fly(weather)
#puts learjet.altitude

learjet.update_target

puts "En el radar, el ATC ve al Learjet con un track de " + learjet.trk.to_s + " una altitud de " + learjet.radar_target.alt + " y una velocidad de " + learjet.gspd.to_s

#wp = Position.new(0.7,0)
#learjet.assigned_waypoint = Waypoint.new("Waypoint", wp)
# Nuevo punto, directamente al norte donde está el avión

learjet.assigned_heading = 180

learjet.assigned_speed = 500

puts learjet.ias
puts learjet.heading

puts learjet.position.x*30
puts learjet.position.y*30