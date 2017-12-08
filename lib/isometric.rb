class Isometric
  def initialize(size, origin)
    @size, @origin = size, origin
  end

  def forward (x,y)
  	newx = origin.x + x * size.x + y * size.x
    newy = origin.y + x * size.y - y * size.y
    zorder = x-y
    yield(newx,newy,zorder)
  end

  def backward (x,y)
  	newx = (((x - origin.x).to_f/size.x + (y - origin.y).to_f/size.y)/2).round
    newy = (((x - origin.x).to_f/size.x - (y - origin.y).to_f/size.y)/2).round     #also this should have worked with to_i rather than round...
    yield(newx,newy)
  end

  private
  attr_reader :size, :origin

end