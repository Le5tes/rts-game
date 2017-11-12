require_relative 'XY'
require_relative 'pathfinding'

class Asset

public
attr_reader :model, :position

def initialize(position, model,worldspace)
  @position, @model, @worldspace = position, model, worldspace
end

def loadFromFile
 #TODO
end

def command(type, target)
 #TODO
end

def tile
  @position
end


private
@position
@health
@weapon
@armour
@unlockTech
@model

end

class Unit < Asset

def tile
 @tile
end

def initialize (position, model, worldspace)
  super(position, model, worldspace)
  @tile = position
end

def move
if @path then
  @position = @path.last
  @tile = @position
  @path.pop
  @path = nil if @path.empty?
end
#TODO change move so that there are intermediate steps
end

def command (target)

    map = @worldspace.map.map{|row| row.map{|tile|
      !tile.occupied
      }
    }
    if target.is_a? XY then
    @path =  best_path(@tile, target , map)
    end

  #: @worldspace.players[target[0]][target[1]].tile  #the asset pointed to by 'target' if an asset

end

private
@speed
@tile

end


class Building < Asset



end

class Weapon


end

class Armour


end

def test_print_map map
  map.each {|row| puts(row.map {|value|
    case value
    when true
      "_"
    else
      "X"
    end
  }.join)}
  end
