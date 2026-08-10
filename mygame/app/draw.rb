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

def draw_timer args
  #A function to draw a timer on the screen as reference
  args.outputs.labels << {
    x:640,
    y:360,
    text: (args.state.timer/12).to_i.to_s,
    size_enum: 0,
    r: 255,
    g: 255,
    b: 255,
    a: 255
  }
end

def draw_status(args, status)
  status.each_with_index do |line, i|
    args.outputs.labels << {
      x:  1000,
      y:  700 - i*25,
      text: line[0],
      size_enum: -3,
      alignment_enum: 0,
      r: line[1][0],
      g: line[1][1],
      b: line[1][2],
      a: line[1][3],
      font: "/mygame/fonts/FreeMonoBold.ttf"
    }
  end
end


def draw_target(args, target)
  #Draw actual radar target
  unless target.contact_lost
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
  end

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

  #Draw ghosts
  for ghost in target.ghosts
    args.outputs.sprites << {
      x: ghost.x,
      y: ghost.y,
      w: 3,
      h: 3,
      path: :solid,
      r: target.ghost_color[0],
      g: target.ghost_color[1],
      b: target.ghost_color[2],
      a: target.ghost_color[3]
    }
  end
end

def draw_tag(args, target)
  tag_params = {
    "BL" => [-3.0,-3.0, -18.0, -18.0, -43.0, -23.0],
    "TL" => [-3.0, 9.0, -18.0,  24.0, -43.0,  44.0],
    "BR" => [6.0, -3.0,  21.0, -18.0,  26.0,  -23.0],
    "TR" => [6.0, 6.0,  21.0,  21.0, 26.0,  44.0]
  }

  
  #Adds line connecting to tag
  args.outputs.lines << {
    x:  target.loc.x + tag_params[target.tag_position][0],
    y:  target.loc.y + tag_params[target.tag_position][1],
    x2: target.loc.x + tag_params[target.tag_position][2],
    y2: target.loc.y + tag_params[target.tag_position][3],
    r:  target.target_color[0],
    g:  target.target_color[1],
    b:  target.target_color[2],
    a:  target.target_color[3],
     blendmode_enum: 1
  }

  #Add tag
  target.generate_tag

  target.tag.each_with_index do |line, i|
    args.outputs.labels << {
      x:  target.loc.x + tag_params[target.tag_position][4],
      y:  target.loc.y + tag_params[target.tag_position][5] - 10*i,
      text: line[0],
      size_enum: -7,
      alignment_enum: 0,
      r: line[1][0],
      g: line[1][1],
      b: line[1][2],
      a: line[1][3],
      font: "/mygame/fonts/FreeMonoBold.ttf"
    }
  end


end


