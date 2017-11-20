class XY
  attr_accessor :x , :y
  def initialize (x,y)
    @x, @y = x, y
  end

  def == (other)
    (other.is_a? XY) && (self.x == other.x && self.y == other.y)
  end

  def copy #because using = sets it to equal to the same instance!!
    XY.new(@x,@y)
  end

  def to_floats
    XY.new(@x.to_f, @y.to_f)
  end

  def integer_co_ords?
    (@x.to_f) == (@x.to_i.to_f) and (@y.to_f) == (@y.to_i.to_f)
  end

end



def pythagoras a , b
  Math.sqrt(((a.x-b.x)**2 + (a.y-b.y)**2).to_f)
end
