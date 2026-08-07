#Let's get this Radar simulator to do some actual radaring.

def draw_background args
  args.outputs.sprites << {
    x: 0,
    y: 0,
    w: 1280,
    h: 720,
    path: '/mygame/sprites/background.png'
  }
end

def draw_target(args, target)

  #Draw actual radar target
  args.outputs.sprites << {
    x: 640,
    y: 360,
    w: 3,
    h: 3,
    path: :solid,
    r: 255,
    g: 255,
    b: 0,
    a: 255
  }

end

def