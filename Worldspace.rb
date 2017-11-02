require 'Player'
require 'Assets'

class WorldSpace

def initialize ( players, map = nil)
  @players, @map = players, map
end

def loadFromFile(file)
#TODO
end

def draw
players.each {|player| player.assets.each{|asset| asset.model.draw(asset.position.x, asset.position.y) }}
end

end
