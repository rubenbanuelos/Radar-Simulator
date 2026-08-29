class Alert
  #Creates a blinking alert and adds a warning to status
  attr_reader :text, :tag, :finished, :color
  attr_accessor :aircraft
  
  def initialize(aircraft, cat)

    yellow = [255,255,0,255]
    @aircraft = aircraft
    duration = 5 #how many times the alert blinks
    @timer = duration * 2

    types = {
      "Sent Handover"    => ["*HANDOVER*","HANDOVER REQUEST SENT", yellow],
      "Receive Handover" => ["*HANDOVER*","HANDOVER REQUEST RECEIVED", yellow],
      "Ident"            => ["*IDENT*","", yellow]
    }

    @text = types[cat][1]
    @tag = types[cat][0]
    @finished = false
    @color = types[cat][2]
  end



  def update
    unless @finished
      
 
      if @aircraft.radar_target.alert
        @aircraft.radar_target.alert = nil
        @timer -= 1
      else
        @aircraft.radar_target.alert = @tag
        @timer -= 1
      end

      @finished = @timer == 0 ? true : false

    end

  end

end