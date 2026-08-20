#USE THIS FILE TO POPULATE ALL THE WAYPOINTS FOR A MAP

require 'json'

waypoints = {
  "WGR"     => {"Whitegrass"           => [182.71, 61.31 ]},
  "JOH"     => {"Johnstone Point"      => [115.73, 62.82 ]},
  "MNL"     => {"Mineral Creek"        => [123.46, 105.48]},
  "ANC"     => {"Anchorage"            => [9.5,   109.68 ]},
  "MDO"     => {"Middleton Island"     => [121.44,  1.84 ]},
  "JOVOM"   => {"JOVOM"                => [207.61, 37.79 ]},
  "FORAT"   => {"FORAT"                => [191.65, 42.16 ]},
  "OXUGE"   => {"OXUGE"                => [190.81, 43.26 ]},
  "KATAT"   => {"KATAT"                => [175.36, 46.36 ]},
  "MODDS"   => {"MODDS"                => [93.56,  23.52 ]},
  "DEALS"   => {"DEALS"                => [89.53,  16.96 ]},
  "WUXAN"   => {"WUXAN"                => [40.48,  26.04 ]},
  "SEWAR"   => {"SEWAR"                => [20.32,  49.55 ]},
  "MURYY"   => {"MURYY"                => [35.61,  68.20 ]},
  "HATUL"   => {"HATUL"                => [13.77,  87.01 ]},
  "HOPER"   => {"HOPER"                => [22.00,  89.53 ]},
  "SNRIS"   => {"SNRIS"                => [28.22,  94.73 ]},
  "5MRWY02" => {"5MRWY02"              => [183.76, 66.01 ]},
  "5MRWY20" => {"5MRWY20"              => [180.40, 56.44 ]},
  "5MRWY07" => {"5MRWY07"              => [14.46, 111.53 ]},
  "5MRWY25" => {"5MRWY25"              => [5.04,  108.00 ]},
  "PAKA"    => {"Tatitlek"             => [113.71, 88.35 ]},
  "PAVD"    => {"Valdez Pioneer Field" => [125.64, 105.4 ]}
}

File.write('waypoints.json', waypoints.to_json)