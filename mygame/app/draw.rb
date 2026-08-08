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
    x: target.loc.x,
    y: target.loc.y,
    w: 3,
    h: 3,
    path: :solid,
    r: target.target_color[0],
    g: target.target_color[1],
    b: target.target_color[2],
    a: target.target_color[3]
  }

  #Draw box around target
  
  args.outputs.borders << {
    x: target.loc.x-3,
    y: target.loc.y-3,
    w: 9,
    h: 9,
    path: :solid,
    r: target.target_color[0],
    g: target.target_color[1],
    b: target.target_color[2],
    a: target.target_color[3]
  }
end

def draw_tag(args, target)
  if target.tag_position = "BL"
    args.outputs.lines << {
      x:  target.loc.x-3,
      y:  target.loc.y-3,
      x2: target.loc.x-18,
      y2: target.loc.y-18,
      r: target.target_color[0],
      g: target.target_color[1],
      b: target.target_color[2],
      a: target.target_color[3],
      blendmode_enum: 1
    }

  end
end


