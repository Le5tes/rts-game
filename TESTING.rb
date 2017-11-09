require 'rubygems'
require 'gosu'
require_relative 'Worldspace'
require_relative 'XY'
require_relative 'Assets'
require_relative 'Model'
require_relative 'Player'
require_relative 'Interface'

######TESTING#####


def basicTest

  testlambda = lambda {
    puts "I do nothing"
  }
  myWindow = MyWindow.new
  labels = [Label.new("my Label", XY.new(50,70))]
  mySecondScreen = Screen.new(labels)
  buttons = [Button.new("my button", XY.new(30,50),XY.new(100,30)) do puts "I do nothing" end,Button.new("my other button", XY.new(30,90),XY.new(150,30)) do myWindow.setScreen(mySecondScreen) end]
  myScreen = Screen.new([],buttons)



  myWindow.setScreen myScreen
  myWindow.show
#sleep 5

#  myWindow.setScreen mySecondScreen
end

def worldspaceTest
    myWindow = MyWindow.new
    img = Gosu::Image.new("imgs/Tile1.png")
    tankimg = Gosu::Image.new("imgs/tank1.png")
    map = Array.new(10) {|x| x = Array.new(10) {|x| x = Tile.new(img,1)} }
    player = Player.new({}, 0xff_900000, 10000)
    my_worldspace = WorldSpace.new({testplayer: player},:testplayer,map,XY.new(0,200))
    tank = Unit.new(XY.new(3,2),  Model.new([tankimg],XY.new(0,0)),my_worldspace)
    tank2 = Unit.new(XY.new(3,3),  Model.new([tankimg],XY.new(0,0)),my_worldspace)
    tank3 = Unit.new(XY.new(3,4),  Model.new([tankimg],XY.new(0,0)),my_worldspace)
    player.add_asset :tank1, tank
    player.add_asset :tank2, tank2
    player.add_asset :tank3, tank3
    #puts map.to_s
    myScreen = Screen.new([],[], my_worldspace)
    myWindow.setScreen myScreen
    myWindow.show
end





worldspaceTest
