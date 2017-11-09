require_relative 'XY'
#implements A* pathfinding on a 2d grid, allows diagonal movement where a straight move scores 2 and a diagonal scores 3

def findpath (start, target, map, openlist = [], closedlist = [], g_value = 0) #Implements A* pathfinding algorithm
  closedlist << start
  return closedlist if closedlist[-1] == target
  surrounding_tiles(start).select {|co_ord| ( within_bounds?(co_ord, map) && (!closedlist.include? co_ord) && map[co_ord.x][co_ord.y]) }.each{|co_ord|
    g = calcg(g_value, start, co_ord)
    h = calch(co_ord,target)
    f = g + h
    openlist << [co_ord, g, h, f]
  }
  return false if openlist.empty?
  openlist.sort! {|a,b| b[3] <=> a[3]}
  newstart = openlist[-1][0]
  newg = openlist[-1][1]
  openlist.pop
   findpath(newstart, target,map,openlist,closedlist,newg)
end

def within_bounds? co_ords, map
  co_ords.x >= 0 && co_ords.y >= 0 && co_ords.x < map.length && co_ords.y < map[0].length
end
def calcg (old_g,current, previous)
  old_g + (current.x-previous.x).abs + (current.y-previous.y).abs + 1
end

def calch (current,target)
  xdif = (current.x - target.x).abs
  ydif = (current.y - target.y).abs
  xdif > ydif ? (xdif-ydif) * 2 + ydif *3 : (ydif-xdif) * 2 + xdif * 3
end

def surrounding_tiles(xy)
  (Array.new(3) {|x| Array.new(3) {|y| XY.new(xy.x + x-1,xy.y + y-1)}}).flatten.reject {|value| value == xy}
end

def test (start, target, map)
  map.each_with_index {|column,x| puts column.map.with_index {|value,y|
    if  x == start.x and y == start.y
      "S"
    elsif x == target.x and y == target.y
      "T"
    elsif value == false
      "X"
    else
      " "
    end
  }.join
 }
 path = findpath start, target, map
 if path == false then
   puts "Couldn't find path"
   return
 end
 map.each_with_index {|column,x| puts column.map.with_index {|value,y|
   if  x == start.x and y == start.y
     "S"
   elsif x == target.x and y == target.y
     "T"
   elsif path.include? (XY.new(x,y))
     "P"
   elsif value == false
     "X"
   else
     " "
   end
 }.join
}
end
