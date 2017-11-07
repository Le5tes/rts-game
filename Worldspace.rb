require 'rubygems'
require 'gosu'
require_relative 'Player'
require_relative 'Assets'
require_relative 'XY'

class WorldSpace

  attr_reader :players, :tilesize
  def initialize (players = {}, map = nil, origin = (XY.new(0,200)), tilesize = (XY.new(24,14)))

    @players, @map, @origin, @tilesize = players, map, origin, tilesize


  end

  def update
    ##TODO
  end

  def loadFromFile(file)
    ##TODO
  end

  def click (x,y)
    #TODO
  end

  def isometric(x,y) #xy co-ordinates to isometric
    newx = @origin.x + x*tilesize.x + y*tilesize.x
    newy = @origin.y + x*tilesize.y - y*tilesize.y
    XY.new(newx,newy)
  end

  def draw #refactor into asset and tile classes? then isometric would have to be as well, or in a seperate space?
    @map.each.with_index {|row, yi| row.each.with_index {|tile, xi|
      xy = isometric((xi),(yi))
      tile.image.draw(xy.x,xy.y,0)
      }}
    @players.each {|key,player| player.assets.each {|asset|
      asset.model.draw(isometric(asset.position.x, asset.position.y))
      }}
  end

end

class Tile
  attr_accessor :image, :type, :occupied #could also add a damage attr to change image to broken ground/craters etc.

  def initialize (image, type)
    @image, @type = image, type
  end

end
