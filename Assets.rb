require_relative 'XY'
require_relative 'pathfinding'

class Asset

public
attr_reader :model, :position, :weapon

def initialize(position, model,worldspace, weapon = Weapon.new)
  @position, @model, @worldspace, @weapon = position, model, worldspace, weapon
end

def loadFromFile
 #TODO
end

def update

end

def command(target)
  @target = @worldspace.players[target[0]].assets[target[1]] if target.is_a? Array
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

def initialize (position, model, worldspace, speed)
  super(position, model, worldspace)
  @tile = position
  @speed = speed
  @position = @tile.to_floats
end

def update
  move
end

def move
  if position.integer_co_ords?
      @tile = @position.copy
    if @path then #find next tile on path
      @next_tile = @path.last.copy
      @path.pop
      @path = nil if @path.empty?

    elsif @target && (pythagoras @target.tile, @tile ) > (weapon.range / 2)
      @path = best_path(@tile, @target.tile, map)
      puts "working-ish"
    end
  end

  if @next_tile && @next_tile != @tile
    @position.x += ((@next_tile.x - @tile.x) * @speed / 100)
    @position.y += ((@next_tile.y - @tile.y) * @speed / 100)
    @position.x = @position.x.round(2)
    @position.y = @position.y.round(2)
  end
 #TODO refactor
end

def command (target)

     
    if target.is_a? XY then
      @path =  best_path(@tile, target , map)

    else
      super
    end


end

private
@speed
@tile
 
 def map
@worldspace.map.map{|row| row.map{|tile|
      !tile.occupied
      }
    }
 end
end


class Building < Asset



end

class Weapon
  attr_reader :range, :damage
  def initialize range = 10
    @range = range
  end

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
