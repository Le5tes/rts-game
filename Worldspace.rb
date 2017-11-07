require 'rubygems'
require 'gosu'
require_relative 'Player'
require_relative 'Assets'
require_relative 'XY'
# at some point seperate all interface functions into a viewport class
#thus all players in a multiplayer game will have their own viewport but only one worldspace entity will exist on the server
#I think worldspace wouldn't even require gosu then? Don't quite understand how requireing works currently, will do some testing later, for now leave as is

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

    puts (get_asset_from_pos(x,y))
    #1st click, return a player key and asset key
    #2nd click return either another player key and asset key or a tile
    #then provide that as a command for the original asset
    #TODO
  end

  def command asset_key, target
    #TODO
  end

#Returns an array containing a playerkey, an assetkey and a z value for an asset, from a mouseclick.
#Returns the asset with the highest z value if multiple on top of each other.
  def get_asset_from_pos(x,y)
    players.map{|key, player| [key, player.assets.map {|key,asset|
      isometric(asset.position.x, asset.position.y) {|x1,y1,z|
         asset.model.within_drawn?(x, y, x1, y1) ? [key,z] : nil
         }
       }.compact].flatten}.sort {|x,y| y[2] <=> x[2] }.first
  end


  def isometric(x,y) #xy co-ordinates to isometric
    newx = @origin.x + x*tilesize.x + y*tilesize.x
    newy = @origin.y + x*tilesize.y - y*tilesize.y
    zorder = x-y
    yield(newx,newy,zorder)
  end

  def draw #done some refactoring, any more to do? One day tiles will need z-order (for hills and the like)
    @map.each.with_index {|row, yi| row.each.with_index {|tile, xi|
      isometric(xi,yi) {|x,y,z|tile.image.draw(x,y,0)}
      }}
    @players.each {|key,player| player.assets.each {|key,asset|
      isometric(asset.position.x, asset.position.y) {|x,y,z| asset.model.draw(x,y,z, player.colour)}
      }}
  end

end

class Tile
  attr_accessor :image, :type, :occupied #could also add a damage attr to change image to broken ground/craters etc.

  def initialize (image, type)
    @image, @type = image, type
  end

end
