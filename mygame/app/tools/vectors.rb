require_relative 'interpolator'

Position = Struct.new(:x, :y)

def get_polar_coordinates(x,y)
  r = Math::sqrt(x**2 + y**2)
  theta = Math::atan2(x,y)
  theta = theta*(180/Math::PI)
  return [r, theta]
end

def get_cartesian_coordinates(r, theta)
  theta = theta*(Math::PI/180)
  x = r*Math::sin(theta)
  y = r*Math::cos(theta)
  return [x,y]
end

def get_heading_difference(current, target)
  #Determines target 
  (target - current + 540) % 360 - 180
end

Profile = Struct.new(:value, :altitude) #Used to store profile data at
  #given altitudes
