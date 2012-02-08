def setup
  size 640,480,P2D

  rectMode CENTER
  
  @xs = [10,20,30,40,50]
  @ys = [20,20,20,20,20]


  @@id = 0
  @inputs = Array.new(4,Input.new(false))
end

def draw
  background 255
  @imputs.each do |input|
    input.draw
  end
end

class Input
  @state
  @id
  @x
  @y

  #attr_accessor @state,@id

  def initialize _state

    @state = _state
    
    @id = @@id
    @@id += 1
    
    @x = @xs[@id]
    @y = @ys[@id]

  end

  def draw
    fill 0xffff0000
    rect @x,@y,10,20

  end

end

