module GlobalParams
    
    MAP_SCALE = 215 #The width of the map in miles
    SPEED_FACTOR = 1/3600 #Converts speed to nautical miles per second
    SCREEN_SIZE = 1280 #Size of standard game screen for Rubydragon
    SCALE_FACTOR = MAP_SCALE/SCREEN_SIZE #Converts miles to pixels
    VS_FACTOR = 1/60 #converts vspeed to ft/sec

end