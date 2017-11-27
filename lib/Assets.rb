require_relative 'XY'
require_relative 'pathfinding'

class Asset
DEFAULT_HEALTH = 100
attr_reader :model, :position, :weapon
attr_writer :player, :key

def initialize(position, model,worldspace, weapon: Weapon.new, health: DEFAULT_HEALTH)
  @position, @model, @worldspace, @weapon, @health = position, model, worldspace, weapon, health
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
  fight
end

def command (target)

     
    if target.is_a? XY then
      @target =  target

    else
      super
    end


end



  def defend (weapon)
    @health -=weapon.damage
    @player.remove_asset @key if @health <= 0
  end

private
 
  def attack (asset)
    @weapon.attack asset
  end

  def move
    if position.integer_co_ords?
      @tile = @position.copy
      if @path then #find next tile on path
        @next_tile = @path.last.copy
        @path.pop
        @path = nil if @path.empty?
      elsif @target.is_a? XY
        @path =  best_path(@tile, @target , map)
      elsif @target && (pythagoras @target.tile, @tile ) > (weapon.range / 2)
        @path = best_path(@tile, @target.tile, map)        
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

  def fight
    if @target.is_a? Asset
      attack @target
    else
      #check for enemies
    end
  end

  def map
    @worldspace.map.map{|row| row.map{|tile|!tile.occupied}}
  end

end


class Building < Asset



end

class Weapon
  attr_reader :range, :damage
  def initialize range: 10, damage: 10, reload_time: 30
    @range = range
    @damage = damage
    @reload_time = reload_time
    @reloading = @reload_time
  end

  def attack asset
    asset.defend self unless reloading
  end
private
  def reloading
    if @reloading == @reload_time 
      @reloading = 0
      false
    else
      @reloading +=1
      true
    end
  end

  def reload_time
    @reload_time
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
