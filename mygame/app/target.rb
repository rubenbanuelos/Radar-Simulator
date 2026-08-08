class RadarTarget

  #tag data
  attr_accessor :callsign, :type, :alt, :gspd, :clrd_alt, :tag_position, :ghosts, :tag, :loc, :cat
  #appearance
  attr_accessor :target_color, :ghost_color
  #flags
  attr_accessor :emergency, :mode_charlie
  attr_reader :in_control
  
  def initialize (callsign)
    
    @target_color = [255,255,0,255]
    @ghost_color = [255,255,0,128]
    @callsign = callsign #Aircraft callsign
    @type = type #Aircraft
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
    @tag = []

    @tag.push([@callsign, yellow])
    @in_control ? @tag.push([@type + @cat, yellow ]) : nil

    if @clrd_alt == @alt 
      @tag.push([@alt, yellow])
    else
      @tag.push([@alt + (@clrd_alt||""), yellow])
    end

    

    @in_control ? @tag.push([@gspd, yellow]) : nil

    @emergency ? @tag.push(["*EMER*", red]) : nil    

  end

  def in_control=(val)
    @in_control = val
    if val == true
      @target_color = [255,255,0,255]
    else
      @target_color = [255,255,0,128]
    end
    puts @target_color
  end

end