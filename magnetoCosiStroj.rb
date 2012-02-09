def setup
  size 640,280,P2D

  rectMode CENTER

  @xs = [80,160,240,320,400]
  @ys = [200,200,200,200,200]


  @@id = 0
  @alins = []


  4.times do |num|
    @alins << Input.new(num,@xs[num],@ys[num])

  end



end

def draw
  background 255

  @alins.each do |input|
    input.draw
  end
end

class Input
  def initialize _id,xs,ys

    @c1 = color(255,0,0)

    @c2 = color(255)

    @state = false

    @ID = _id

    @x = xs
    @y = ys

  end


  def check
    if(over)
      @state = !@state
    end
  end

  def draw
    fill(@state ? @c1 : @c2)
    rect @x,@y,10,20

    if(mousePressed)
      check
    end

  end

  def over
    odpoved = false

    if(mouseX > @x - 5 && mouseX < @x + 5 && mouseY > @y - 10 && mouseY< @y + 10)
      odpoved = true
    end

    return odpoved
  end

end

