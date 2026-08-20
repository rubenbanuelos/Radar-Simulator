#USE THIS FILE TO GENERATE A DRAGONRUBY PARSEABLE JSON WITH AIRCRAFT PROFILES
#THIS REQUIRES RUBY STANDARD LIBRARIES AND CANNOT BE CALLED THROUGH DRAOGNRUBY


require 'json'


catalog = {
  "PA18" => {:type => "Piston Single-Engine", :category => "L"},
  "PA12" => {:type => "Piston Single-Engine", :category => "L"},
  "C185" => {:type => "Piston Single-Engine", :category => "L"},
  "C180" => {:type => "Piston Single-Engine", :category => "L"},
  "C170" => {:type => "Piston Single-Engine", :category => "L"},
  "C206" => {:type => "Piston Multi-Engine", :category => "L"},
  "C207" => {:type => "Turboprop Single-Engine", :category => "L"},
  "C208" => {:type => "Turboprop Single-Engine", :category => "L"},
  "C172" => {:type => "Piston Single-Engine", :category => "L"},
  "C182" => {:type => "Piston Single-Engine", :category => "L"},
  "DHC2" => {:type => "Piston Single-Engine", :category => "L"},
  "DHC3" => {:type => "Piston Single-Engine", :category => "L"},
  "DHC6" => {:type => "Piston Multi-Engine", :category => "L"},
  "PA31" => {:type => "Turboprop Multi-Engine", :category => "L"},
  "PAY2" => {:type => "Turboprop Multi-Engine", :category => "L"},
  "BE20" => {:type => "Turboprop Multi-Engine", :category => "L"},
  "BE19" => {:type => "Piston Single-Engine", :category => "L"},
  "DH8A" => {:type => "Turboprop Multi-Engine", :category => "M"},
  "B732" => {:type => "Jet", :category => "M"},
  "B734" => {:type => "Jet", :category => "M"},
  "B737" => {:type => "Jet", :category => "M"},
  "B738" => {:type => "Jet", :category => "M"},
  "B739" => {:type => "Jet", :category => "M"},
  "B752" => {:type => "Jet", :category => "H"},
  "B77L" => {:type => "Jet", :category => "H"},
  "B74F" => {:type => "Jet", :category => "H"},
  "A320" => {:type => "Jet", :category => "M"},
  "A330" => {:type => "Jet", :category => "H"},
  "A340" => {:type => "Jet", :category => "H"},
  "B763" => {:type => "Jet", :category => "H"},
  "BE58" => {:type => "Piston Multi-Engine", :category => "L"},
  "B06T" => {:type => "Helicopter", :category => "L"}
}

catalog.default = {:type => "Piston Single-Engine", :category => "L"}
 
profile_sheets = {
  "Jet" => {
    "Climb Rate" => {
      0     => 4500,
      2000  => 3000,
      5000  => 2500,
      10000 => 2000,
      20000 => 1500,
      40000 => 1000,
      42000 => 1
    },

    "Descent Rate" => {
      0      => 250,  
      500    => 750,
      10000  => 1000,
      20000  => 1500,
      30000  => 3000,
      40000  => 4000,
      42000  => 4500
    },

    "Cruise Speed" => {
      0     => 250,
      10000 => 250,
      20000 => 330,
      30000 => 300,
      40000 => 280,
      42000 => 250
    },


    "Climb Speed" => {
      0     => 250,
      10000 => 250,
      20000 => 280,
      30000 => 300,
      40000 => 250,
      42000 => 220
    },

    "Descent Speed" => {
      0     => 160,
      10000 => 200,
      20000 => 250,
      30000 => 280,
      40000 => 280,
      42000 => 250
    },

    "Top Speed" => {
      0     => 250, 
      10000 => 250, 
      20000 => 350, 
      30000 => 300,
      40000 => 280, 
      42000 => 250
    },

    "Acceleration" => {
      0     => 6.0,
      1000  => 4.0,
      10000 => 2.0,
      20000 => 1.5,
      42000 => 1.0
    },

    "Deceleration" => {
      0     => 1.0,
      1000  => 2.0,
      10000 => 2.0,
      20000 => 2.5,
      42000 => 3.0
    },

    "Stall Speed" => 120,
    "Ceiling" => 42000,
    "Turn rate" => 3
    

  },

  "Helicopter" =>{
    "Climb Rate" => {
      0     => 2000,
      2000  => 1500,
      10000 => 1000,
      13500 => 1,
    },

    "Descent Rate" => {
      0      => 150,
      200    => 500,
      1000   => 1000,
      10000  => 2000,
      13500  => 2500
    },

    "Cruise Speed" => {
      0     => 110,
      13500 => 70
    },


    "Climb Speed" => {
      0     => 90,
      13500 => 50
    },

    "Descent Speed" => {
      0     => 80,
      10000 => 120,
      13500 => 90
    },

    "Top Speed" => {
      0     => 130, 
      13500 => 80
    },

    "Acceleration" => {
      0     => 1.0,
      1000  => 2.0,
      13500 => 1.0
    },

    "Deceleration" => {
      0     => 1.0,
      13500 => 2.5
    },

    "Stall Speed" => 0,
    "Ceiling" => 13500,
    "Turn rate" => 3

  },

  "Turboprop Multi-Engine" => {
    "Climb Rate" => {
      0     => 3000,
      2000  => 2500,
      5000  => 2000,
      10000 => 1500,
      20000 => 1000,
      30000 => 500,
      33000 => 1
    },

    "Descent Rate" => {
      0      => 250,  
      500    => 500,
      10000  => 1000,
      20000  => 2000,
      30000  => 3000,
      33000  => 4000
    },

    "Cruise Speed" => {
      0     => 250,
      10000 => 250,
      20000 => 230,
      30000 => 220,
      35000 => 200,
    },


    "Climb Speed" => {
      0     => 250,
      10000 => 250,
      20000 => 210,
      30000 => 180,
      35000 => 170
    },

    "Descent Speed" => {
      0     => 100,
      2000  => 120,
      10000 => 250,
      20000 => 280,
      30000 => 250,
      35000 => 200
    },

    "Top Speed" => {
      0     => 250, 
      10000 => 250, 
      20000 => 290, 
      30000 => 270,
      35000 => 220
    },

    "Acceleration" => {
      0     => 4.0,
      1000  => 3.5,
      10000 => 2.0,
      20000 => 1.0,
      35000 => 0.5
    },

    "Deceleration" => {
      0     => 1.0,
      1000  => 2.0,
      10000 => 2.0,
      20000 => 2.5,
      35000 => 4.0
    },

    "Stall Speed" => 80,
    "Ceiling" => 35000,
    "Turn rate" => 3

  },

  "Turboprop Single-Engine" => {
    "Climb Rate" => {
      0     => 2500,
      2000  => 2000,
      5000  => 1700,
      10000 => 1300,
      20000 => 800,
      25000 => 1
    },

    "Descent Rate" => {
      0      => 250,  
      500    => 350,
      10000  => 1000,
      20000  => 2000,
      25000  => 3000
    },

    "Cruise Speed" => {
      0     => 110,
      10000 => 90,
      20000 => 80,
      25000 => 75
    },


    "Climb Speed" => {
      0     => 90,
      10000 => 75,
      20000 => 70,
      25000 => 65
    },

    "Descent Speed" => {
      0     => 65,
      2000  => 90,
      10000 => 110,
      20000 => 110,
      25000 => 100
    },

    "Top Speed" => {
      0     => 130, 
      10000 => 120, 
      20000 => 100, 
      25000 => 85
    },

    "Acceleration" => {
      0     => 2.5,
      1000  => 2.5,
      10000 => 2.0,
      20000 => 1.0,
      25000 => 0.5
    },

    "Deceleration" => {
      0     => 1.0,
      1000  => 2.0,
      10000 => 2.0,
      20000 => 2.5,
      25000 => 4.0
    },

    "Stall Speed" => 55,
    "Ceiling" => 25000,
    "Turn rate" => 3

  },
  
  "Piston Single-Engine" => {
    "Climb Rate" => {
      0     => 2000,
      2000  => 1500,
      5000  => 1000,
      10000 => 700
    },

    "Descent Rate" => {
      0      => 200,  
      500    => 300,
      5000   => 1000,
      10000  => 2000
    },

    "Cruise Speed" => {
      0     => 110,
      10000 => 70
    },


    "Climb Speed" => {
      0     => 80,
      10000 => 65
    },

    "Descent Speed" => {
      0     => 50,
      2000  => 70,
      10000 => 110
    },

    "Top Speed" => {
      0     => 130, 
      10000 => 90
    },

    "Acceleration" => {
      0     => 1.5,
      1000  => 1.5,
      10000 => 1.0
    },

    "Deceleration" => {
      0     => 1.0,
      1000  => 2.0,
      10000 => 2.0
    },

    "Stall Speed" => 50,
    "Ceiling" => 10000,
    "Turn rate" => 3

  },

  "Piston Multi-Engine" => {
    "Climb Rate" => {
      0     => 2500,
      2000  => 2000,
      5000  => 1500,
      12000 => 1200
    },

    "Descent Rate" => {
      0      => 200,  
      500    => 400,
      5000   => 1000,
      12000  => 2000
    },

    "Cruise Speed" => {
      0     => 160,
      12000 => 120
    },


    "Climb Speed" => {
      0     => 130,
      12000 => 100
    },

    "Descent Speed" => {
      0     => 85,
      2000  => 90,
      10000 => 150
    },

    "Top Speed" => {
      0     => 180, 
      10000 => 160
    },

    "Acceleration" => {
      0     => 2.5,
      1000  => 2.0,
      12000 => 1.0
    },

    "Deceleration" => {
      0     => 1.0,
      1000  => 2.0,
      10000 => 2.0
    },

    "Stall Speed" => 75,
    "Ceiling" => 12000,
    "Turn rate" => 3

  }

}

File.write('profiles.json', profile_sheets.to_json)
File.write('catalog.json', catalog.to_json)



