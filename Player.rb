require_relative 'Assets'
class Player
attr_reader :assets, :colour, :cash
def initialize (starting_assets,colour, starting_cash)
  @assets, @colour, @cash = starting_assets, colour, starting_cash
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
end
#TODO create + destroy etc.

end
