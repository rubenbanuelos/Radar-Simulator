class RadarTarget

  #tag data
  attr_accessor :callsign, :type, :alt, :gspd, :clrd_alt, :tag_position, :ghosts, :tag, :loc, :cat, :alert
  #appearance
  attr_accessor :target_color, :ghost_color
  #flags
  attr_accessor :emergency, :in_control, :mva
  attr_reader :squawk_ifr
  
  attr_accessor :contact_lost, :contact_lost_stage_2
  
  def initialize (callsign)
    
    @target_color = [255,255,0,255]
    @ghost_color = [128,128,0,255]
    @callsign = callsign #Aircraft callsign
    @type = type #Aircraft
    @alt = "" #Aircraft altitude
    @gspd = "" #Aircraft ground speed
    @clrd_alt = nil #Aircraft current cleared altitude
    @tag_position = "BR"
    @tag = []
    @ghosts = [] #Ghost tracks following the airplane
    @loc = Position.new(0,0)
    @alert = nil

    @emergency = false
    @squawk_ifr = true
    @in_control = true
    @mva = false

    #specific parameters for crash
    @contact_lost = false
    @contact_lost_stage_2 = false
    
  end

  def generate_tag
    yellow = [255,255,0]
    red = [255,0,0]
    @tag = []
    @tag.push(["", yellow])

    if @in_control 
      @tag.push([@callsign, yellow])
      @tag.push([@type + " " + @cat, yellow ])
    end

    unless @contact_lost_stage_2
      if @clrd_alt == @alt 
        @tag.push([@alt, yellow])
      else
        if @in_control
          @tag.push([@alt + (@clrd_alt||""), yellow])
        else
          @tag.push([@alt, yellow])
        end
      end
    end

    
    unless @contact_lost_stage_2
      @tag.push([@gspd, yellow])
    end
    
    unless @alert
      @tag[0][1] = red
      @emergency ? @tag[0][0] << "*EMER*" : nil    
      @mva ? @tag[0][0] << "*MVA*" : nil
    else  
      tag[0][0] = @alert
    end
  end

  def squawk_ifr=(val)
    @squawk_ifr = val
    if val == true
      @target_color = [255,255,0,255]
    else
      @target_color = [128,128,0,255]
    end
  end

end