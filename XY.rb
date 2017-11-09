class XY
  attr_accessor :x , :y
  def initialize (x,y)
    @x, @y = x, y
  end
  def == (other)
    (other.is_a? XY) && (self.x == other.x && self.y == other.y)
  end
end
