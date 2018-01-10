require 'rubygems'
require 'gosu'
require_relative 'XY'
class Model
attr_reader :origin, :size

def initialize (images: nil, origin: XY.new(0,0), size: XY.new(50,30))
  @images, @origin, @size = images, origin, size
  @currentimg = @images[0]
end

def draw x, y, z, colour = 0xff_ffffff
  @currentimg.draw x - @origin.x, y - @origin.y, z, 1, 1, colour
end

#returns true or false to indicate whether a set of co-ordinates (x1,y1) is within the bounds of the model's drawn image based on it's draw co-ordinates (x2,y2)
def within_drawn? x1, y1, x2, y2
  ((x2 - @origin.x) < x1 && x1 < (x2 - origin.x + size.x) && (y2 - @origin.y) < y1 && y1 < (y2 - origin.y + size.y))
end
end
