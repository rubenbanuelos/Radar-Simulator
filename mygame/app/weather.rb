require_relative "vectors"

class Weather
  attr_accessor :temperature_layers, :wind_layers, :altimeter

  def initialize
    @altimeter = 29.92
    @temperature_layers = []
    @wind_layers =[]
  end

end

Wind = Struct.new(
  :speed,
  :heading
)

def interpolate_wind (weather, altitude)
  for entry in weather.wind_layers
    if altitude >= entry.altitude
      lower_altitude = entry.altitude
      lower_wind = entry.value
    end
  end

  for entry in weather.wind_layers.reverse
    if altitude <= entry.altitude
      higher_altitude = entry.altitude
      higher_wind = entry.value
    end
  end

  #get wind components

  lw = get_cartesian_coordinates(lower_wind.speed, lower_wind.heading)
  hw = get_cartesian_coordinates(higher_wind.speed, higher_wind.heading)

  lw_x = lw[0]
  lw_y = lw[1]

  hw_x = hw[0]
  hw_y = hw[1]

  if lower_altitude == higher_altitude
    interpolation = lower_wind
  else
    f = (altitude-lower_altitude).to_f / (higher_altitude - lower_altitude).to_f
    iw_x = lw_x.to_f + f*(hw_x-lw_x).to_f
    iw_y = lw_y.to_f + f*(hw_y-lw_y).to_f
  end

  iw = get_polar_coordinates(iw_x,iw_y)

  return Wind.new(iw[0],iw[1])

end

def calculate_tas(weather, altitude, ias)
  pressure_altitude =
    altitude + (29.92 - weather.altimeter) * 1000.0

  altitude_m = pressure_altitude * 0.3048

  p0 = 101325.0 #pressure pascals
  t0 = 288.15
  lapse = 0.0065
  gas_constant = 287.05
  rho0 = 1.225

  pressure =
    p0 *
    (1.0 - lapse * altitude_m / t0) ** 5.25588

  temperature_k = interpolator(weather.temperature_layers, altitude) + 273.15

  density = pressure / (gas_constant * temperature_k)

  return ias * Math.sqrt(rho0 / density)

end

