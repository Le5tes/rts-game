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
  fight
end

def command(target)
  @target = @worldspace.players[target[0]].assets[target[1]] if target.is_a? Array
end

def tile
  @position
end


private

 def fight
    if @target.is_a? Asset
      attack @target
    else
      #check for enemies
    end
  end

  def attack (asset)
    @weapon.attack asset
  end


@position
@health
@weapon
@armour
@unlockTech
@model

end

class Unit < Asset
attr_reader :tile

  def initialize (position, model, worldspace, speed)
    super(position, model, worldspace)
    @tile = position
    @speed = speed
    @position = @tile.to_floats
    occupy tile
  end

  def update
    move
    super
  end

  def command (target)     
    if target.is_a? XY then
      @target =  target

    else
      super
    end
  end

  def defend_against (weapon)
    @health -=weapon.damage
    die if @health <= 0
  end

private

  def move
    if position.integer_co_ords?
      if @position == @next_tile
        leave(@tile)
        @next_tile = nil
        @tile = @position.copy.to_integers
      end

      if @path then #find next tile on path
        @next_tile = @path.pop.to_floats 
        if occupied? @next_tile
          @path = nil
        else
          occupy @next_tile       
          @path = nil if @path.empty?
        end
      else
        if @target.is_a? XY
          @tile == @target ? @target = nil : get_path(@target)
        elsif @target && (pythagoras @target.tile, @tile ) > (weapon.range / 2)
          get_path @target.tile       
        end
      end
      
    end

    if @next_tile
      step_between @tile, @next_tile
    end
 #TODO refactor
  end

  def worldspace
    @worldspace
  end

  def occupy (tile)
    worldspace.map(tile).occupied = true
  end

  def occupied? tile
    worldspace.map(tile).occupied
  end
  
  def leave (tile)
    worldspace.map(tile).occupied = false
  end

  def get_path (target)
    @path =  best_path(@tile, target , map)
  end

  def step_between tile, next_tile
    @position.x += ((next_tile.x - tile.x) * @speed / 100)
    @position.y += ((next_tile.y - tile.y) * @speed / 100)
    @position.round!(2)
  end

  def die
    leave @tile
    @player.remove_asset @key 
  end

  def map
    worldspace.map.map{|row| row.map{|tile|!tile.occupied}}
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
    asset.defend_against self unless reloading
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
