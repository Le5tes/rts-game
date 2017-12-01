require_relative 'Assets'
class Player
attr_reader :assets, :colour, :cash, :key
def initialize (starting_assets,colour, starting_cash, key)
  @assets, @colour, @cash, @key = starting_assets, colour, starting_cash, key
end

def bill cost
  @cash -=cost
end

def can_afford? cost
  @cash >= cost
end

def earn money
  @cash += money
end

def add_asset key, asset
  @assets[key] = asset
  asset.player = self
  asset.key = key
end

def remove_asset key
  @assets.delete key
end
#TODO create + destroy etc.

end
