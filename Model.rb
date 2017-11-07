require 'rubygems'
require 'gosu'
require_relative 'XY'
class Model

def initialize (images, origin)
  @images, @origin = images, origin
  @currentimg = @images[0]
end

def draw x, y, z
  x -=@origin.x
  y -=@origin.y
  @currentimg.draw x, y, z
end

end
