require 'rubygems'
require 'gosu'
require_relative 'Player'
require_relative 'Assets'
require_relative 'Model'
require_relative 'XY'
require_relative 'isometric'
# at some point seperate all interface functions into a viewport class
#thus all players in a multiplayer game will have their own viewport but only one worldspace entity will exist on the server
#I think worldspace wouldn't even require gosu then? Don't quite understand how requireing works currently, will do some testing later, for now leave as is

class WorldSpace

  attr_reader :players, :tilesize
  def initialize (players = {} , current_player = nil, map = nil, origin = (XY.new(0,200)), tilesize = (XY.new(24,14)))

    @players, @currentplayer, @map, @origin, @tilesize = players, current_player, map, origin, tilesize
    @isometric = Isometric.new(tilesize, origin)

  end

  def update
    players.each {|key,player| player.assets.each{|key,asset| asset.update}}
  end

  def loadFromFile(file)
    ##TODO
  end

  def map (xy = nil)
    if xy
      map[xy.x][xy.y]
    else
      @map
    end
  end

  def click (x,y)

    if  !@currentcommand
      #1st click, return a player key and asset key
      command_asset = get_asset_from_pos(x,y)
      @currentcommand = command_asset if (command_asset && command_asset.player.key == @currentplayer)
    else
      #2nd click return either another player key and asset key or a tile
      #then provide that as a command for the original asset
      target =  @isometric.backward(x,y) {|x,y| XY.new(x-1,y)} unless (target = get_asset_from_pos(x,y))
      command @currentcommand, target
      @currentcommand = nil
    end
    #TODO
  end

  def command asset, target
    puts "Command asset: #{asset.key.to_s}, target: #{target.to_s}"
    asset.command target
  end

#Returns an array containing a playerkey, an assetkey and a z value for an asset, from a pair of co-ordinates corresponding to a mouseclick.
#Returns the asset with the highest z value if multiple on top of each other.
  def get_asset_from_pos(x,y)

    a = assets.map{|asset|[asset,
    @isometric.forward(asset.position.x, asset.position.y) {|x1,y1,z|
      asset.model.within_drawn?(x, y, x1, y1) ? z : nil
    }]}
    .select{|value| value[1]}
    .sort{|a,b| b[1] <=> a[1]}
    .first
    
    a.first if a
  end

  def assets
    players.map{|key, player| player.assets.map{|key,asset| asset}}.flatten
  end

  def draw #done some refactoring, any more to do? One day tiles will need z-order (for hills and the like)
    @map.each.with_index {|row, yi| row.each.with_index {|tile, xi|
      @isometric.forward(xi,yi) {|x,y,z|tile.image.draw(x,y,z-100)}
      }}
    assets.each{|asset|
      @isometric.forward(asset.position.x, asset.position.y) {|x,y,z| asset.model.draw(x,y,z, asset.player.colour)}
      }
  end

end

class Tile
  attr_accessor :image, :type, :occupied #could also add a damage attr to change image to broken ground/craters etc.

  def initialize (image, type)
    @image, @type = image, type
  end

end
