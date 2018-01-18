require_relative 'XY'
require_relative 'pathfinding'
require 'active_support/core_ext/hash'

class Asset
DEFAULT_HEALTH = 100
attr_reader :model, :position, :weapon, :health, :player, :key 
attr_writer :player, :key

def initialize(position: XY.new(), model: nil, worldspace:nil , weapon: Weapon.new, health: DEFAULT_HEALTH , created_assets: [])
  @position, @model, @worldspace, @weapon, @health, @created_assets = position, model, worldspace, weapon, health, created_assets
  occupy @position
end

def loadFromFile
 #TODO
end

def update
  fight
end

def command(target)
  @target = target 
end

def tile
  @position
end

def defend_against (weapon)
  @health -=weapon.damage
  die if health <= 0
end

def draw x,y,z
  model.draw(x,y,z,player.colour)
end

private
attr_reader :worldspace, :target
attr_writer :target

 def fight
    if target.is_a? Asset
      attack_target unless out_of_range?(target.position) 
    end
    @target = scan_for_enemies unless target
  end

  def scan_for_enemies
    t = worldspace.assets.reject {|asset| out_of_range?(asset.position) || (asset.player == player) }
    t.first unless t.empty?
  end

  def die
    leave tile
    player.remove_asset key 
  end

  def attack_target
    attack(target)
    @target = nil if target.health <=0
  end

  def attack (asset)
    weapon.attack asset
  end

  def out_of_range? target
    pythagoras(@position,target) > weapon.range
  end

  def occupy(locus)
    worldspace.map(locus).occupied = true
  end

  def occupied? tile
    worldspace.map(tile).occupied
  end
  
  def leave (locus)
    worldspace.map(locus).occupied = false
  end

# @armour
# @unlockTech
# @model

end

class Unit < Asset
attr_reader :tile

  def initialize (params)
    @speed = params[:speed]
    super(params.except(:speed))
    @tile = params[:position]
    
    @position = @tile.to_floats
  end

  def update
    move
    super
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
        @path = nil if @path.empty?

        if occupied? @next_tile
          @next_tile = nil
          @path = nil
        else
          occupy @next_tile       
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

  

  def get_path (target)
    @path =  best_path(@tile, target , map)
  end

  def step_between tile, next_tile
    @position.x += ((next_tile.x - tile.x) * @speed / 100)
    @position.y += ((next_tile.y - tile.y) * @speed / 100)
    @position.round!(2)
  end

  def map
    worldspace.map.map{|row| row.map{|tile|!tile.occupied}}
  end

end


class Building < Asset

  def initialize(params)
    @size = params[:size]
    @size ||= XY.new(1,1)
    super(params.except(:size))
  end

  private
  attr_reader :size

  def fight
    target = nil if target && out_of_range?(target) 
    super
  end

  def occupy(locus)
    all_squares(locus) { |square|
      super(square)
    }
  end

  def leave(locus)
    all_squares(locus) { |square|
      super(square)
    }
  end

  def all_squares(locus)
    size.x.times{|x| size.y.times {|y|
      yield(XY.new(locus.x + x,locus.y + y))
    }} 
  end

  def build_asset(asset)
    player.add_asset(asset)
  end

end

class Weapon
  attr_reader :range, :damage
  def initialize range: 5, damage: 10, reload_time: 30
    @range = range
    @damage = damage
    @reload_time = reload_time
    @reloading = reload_time
  end

  def attack asset
    asset.defend_against self unless reloading
  end
private
  def reloading
    if @reloading == reload_time 
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

class Tech
  def initialize (args)

  end
  
end



class Armour


end
