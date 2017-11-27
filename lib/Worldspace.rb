require 'rubygems'
require 'gosu'
require_relative 'Player'
require_relative 'Assets'
require_relative 'XY'
# at some point seperate all interface functions into a viewport class
#thus all players in a multiplayer game will have their own viewport but only one worldspace entity will exist on the server
#I think worldspace wouldn't even require gosu then? Don't quite understand how requireing works currently, will do some testing later, for now leave as is

class WorldSpace

  attr_reader :players, :tilesize, :map
  def initialize (players = {} , current_player = nil, map = nil, origin = (XY.new(0,200)), tilesize = (XY.new(24,14)))

    @players, @currentplayer, @map, @origin, @tilesize = players, current_player, map, origin, tilesize


  end

  def update
    players.each {|key,player| player.assets.each{|key,asset| asset.update}}
  end

  def loadFromFile(file)
    ##TODO
  end

  def click (x,y)

    #puts (get_asset_from_pos(x,y))
    #puts ""
    if  !@currentcommand
      #1st click, return a player key and asset key
      command_asset_keys = get_asset_from_pos(x,y)
      @currentcommand = command_asset_keys[1] if (command_asset_keys && command_asset_keys[0] == @currentplayer)
    else
      #2nd click return either another player key and asset key or a tile
      #then provide that as a command for the original asset
      target =  rev_isometric(x,y) {|x,y| XY.new(x,y)} unless (target = get_asset_from_pos(x,y))
      command @currentcommand, target
      @currentcommand = nil
    end
    #TODO
  end

  def command asset_key, target
    puts "Command asset: #{asset_key.to_s}, target: #{(target.is_a? Array) ? target.to_s : target.x.to_s + "," + target.y.to_s }"
    @players[@currentplayer].assets[asset_key].command target
  end

#Returns an array containing a playerkey, an assetkey and a z value for an asset, from a pair of co-ordinates corresponding to a mouseclick.
#Returns the asset with the highest z value if multiple on top of each other.
  def get_asset_from_pos(x,y)
    a = players.map{|key, player| [key, player.assets.map {|key,asset|
      isometric(asset.position.x, asset.position.y) {|x1,y1,z|
         asset.model.within_drawn?(x, y, x1, y1) ? [key,z] : nil
         }
       }.compact.sort {|x,y| y[1] <=> x[1] }.first].flatten
       }.select{|value| value[1]}.sort {|x,y| y[2] <=> x[2] }.first
  end

  def isometric(x,y) #grid co-ordinates to isometric screen co-ordinates
    newx = @origin.x + x*tilesize.x + y*tilesize.x
    newy = @origin.y + x*tilesize.y - y*tilesize.y
    zorder = x-y
    yield(newx,newy,zorder)
  end

  def rev_isometric(x,y) #isometric screen co-ordinates to grid co-ordinates
    newx = (((x - @origin.x).to_f/tilesize.x + (y - @origin.y).to_f/tilesize.y)/2).round - 1 #too lazy to work out why this was off by 1 so just subtracted 1...
    newy = (((x - @origin.x).to_f/tilesize.x - (y - @origin.y).to_f/tilesize.y)/2).round     #also this should have worked with to_i rather than round...
    yield(newx,newy)
  end

  def draw #done some refactoring, any more to do? One day tiles will need z-order (for hills and the like)
    @map.each.with_index {|row, yi| row.each.with_index {|tile, xi|
      isometric(xi,yi) {|x,y,z|tile.image.draw(x,y,-1900)}
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
