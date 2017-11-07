require_relative 'XY'

class Asset

public
attr_reader :model, :position

def initialize(position, model)
  @position, @model = position, model
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

def move
#TODO
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
