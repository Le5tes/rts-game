require 'rubygems'
require 'gosu'
require_relative 'XY'
class Model

def initialize (images, origin)
  @images, @origin = images, origin
  @currentimg = @images[0]
end

def draw position
  x = position.x-@origin.x
  y = position.y-@origin.y
  @currentimg.draw x, y, 0
end

end
