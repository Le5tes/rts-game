require 'rubygems'
require 'gosu'
require_relative 'XY'
class Model
attr_reader :origin, :size

def initialize (images, origin, size = XY.new(50,30))
  @images, @origin, @size = images, origin, size
  @currentimg = @images[0]
end

def draw x, y, z, colour = 0xff_ffffff
  @currentimg.draw x - @origin.x, y - @origin.y, z, 1, 1, colour
end


end
