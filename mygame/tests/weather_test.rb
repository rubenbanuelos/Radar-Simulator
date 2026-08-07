require_relative "../app/world/weather"
require_relative "../app/tools/vectors"

#Vamos a crear un sistema meteorológico


#creamos capas de viento
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

puts "Inician pruebas"

puts interpolate_wind(weather, 18000)

puts calculate_tas(weather,10000, 250)