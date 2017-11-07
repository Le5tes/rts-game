class model

def initialize images, origin = XY.new(0,0)
  @images, @origin = images, origin
  @currentimg = @images[0]
end

def draw position
  @currentimg.draw (position.x-@origin.x, position.y-@origin.y, 0)
end

end
