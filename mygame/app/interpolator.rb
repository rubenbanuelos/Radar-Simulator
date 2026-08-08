def interpolator(table, altitude)
  #Function to interpolate the values from a table for performance or weather
  #This function takes a altitude and interpolates a corresponding value
  #from a table
  
  lower_altitude = 0
  higher_altitude = 0
  lower_val = 0
  higher_val = 0


  for entry in table
    if altitude >= entry.altitude
      lower_altitude = entry.altitude
      lower_val = entry.value
    end
  end

  for entry in table.reverse
    if altitude <= entry.altitude
      higher_altitude = entry.altitude
      higher_val = entry.value
    end
  end

  if lower_altitude == higher_altitude
    interpolation = lower_val
  else
    f = (altitude-lower_altitude).to_f / (higher_altitude - lower_altitude).to_f
    interpolation = lower_val.to_f + f*(higher_val-lower_val).to_f
  end

  return interpolation


end



