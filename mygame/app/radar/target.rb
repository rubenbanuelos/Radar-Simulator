class RadarTarget

  #tag data
  attr_accessor :callsign, :type, :alt, :gspd, :clrd_alt, :tag_position, :ghosts, :tag
  #appearance
  attr_accessor :target_color, :ghost_color
  #flags
  attr_accessor :emergency, :mode_charlie, :in_control
  
  def initialize (callsign, type, cat)
    
    @target_color = [255,255,0,255]
    @ghost_color = [255,255,0,128]
    @callsign = callsign #Aircraft callsign
    @type = type + cat #Aircraft type and category
    @alt = "" #Aircraft altitude
    @gspd = "" #Aircraft ground speed
    @clrd_alt = nil #Aircraft current cleared altitude
    @tag_position = "BL"
    @tag = []
    @ghosts = [] #Ghost tracks following the airplane
    @loc = Position.new(0,0)

    @emergency = false
    @mode_charlie = true
    @in_control = true


  end

  def generate_tag
    yellow = [255,255,0]
    red = [255,0,0]

    @tag.push([callsign, yellow])
    @in_control ? @tag.push([type, yellow ]) : nil

    if in_control
      @tag.push([(@alt + @clrd_alt), yellow])
    else
      @tag.push = [@alt, yellow]
    end

    @emergency ? @tag.push["*EMER*", red] : nil    

  end

end