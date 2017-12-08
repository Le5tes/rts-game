require 'rubygems'
require 'gosu'
require './lib/Worldspace'
require './lib/XY'
require './lib/Assets'
require './lib/Model'
require './lib/Player'
require './lib/Interface'

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
    turretimg = Gosu::Image.new("imgs/turret1.png")
    map = Array.new(15) {|x| x = Array.new(15) {|x| x = Tile.new(img,1)} }
    player = Player.new({}, 0xff_900000, 10000, :testplayer)
    player2 = Player.new({}, 0xff_009000, 10000, :otherplayer)
    my_worldspace = WorldSpace.new({testplayer: player, otherplayer: player2},:otherplayer,map,XY.new(0,200))
    tank = Unit.new(XY.new(3,2),  Model.new([tankimg],XY.new(0,0)),my_worldspace,10)
    tank2 = Unit.new(XY.new(3,3),  Model.new([tankimg],XY.new(0,0)),my_worldspace,10)
    tank3 = Unit.new(XY.new(3,4),  Model.new([tankimg],XY.new(0,0)),my_worldspace,10)
    tank4 = Unit.new(XY.new(12,13),  Model.new([tankimg],XY.new(0,0)),my_worldspace,10)
    tank5 = Unit.new(XY.new(12,8),  Model.new([tankimg],XY.new(0,0)),my_worldspace,10)
   tank6 = Unit.new(XY.new(12,9),  Model.new([tankimg],XY.new(0,0)),my_worldspace,10)
   tank7 = Unit.new(XY.new(12,10),  Model.new([tankimg],XY.new(0,0)),my_worldspace,10)
   tank8 = Unit.new(XY.new(12,11),  Model.new([tankimg],XY.new(0,0)),my_worldspace,10)
   tank9 = Unit.new(XY.new(3,5),  Model.new([tankimg],XY.new(0,0)),my_worldspace,10)
   tank10 = Unit.new(XY.new(3,7),  Model.new([tankimg],XY.new(0,0)),my_worldspace,10)
   
    turret1 = Building.new(XY.new(8,8),Model.new([turretimg],XY.new(0,4)),my_worldspace)
    turret2 = Building.new(XY.new(4,4),Model.new([turretimg],XY.new(0,4)),my_worldspace)
    turret3 = Building.new(XY.new(12,12),Model.new([turretimg],XY.new(0,4)),my_worldspace)
   

    player.add_asset :tank1, tank
    player.add_asset :tank2, tank2
    player.add_asset :tank3, tank3
    player2.add_asset :tank4, tank4
    player2.add_asset :tank5, tank5
    player2.add_asset :tank6, tank6
    player2.add_asset :tank7, tank7
    player2.add_asset :tank8, tank8
    player2.add_asset :turret1, turret1
    player2.add_asset :turret3, turret3
    player.add_asset :turret2, turret2
    player.add_asset :tank9, tank9
    player.add_asset :tank10, tank10



    #puts map.to_s
    myScreen = Screen.new([],[], my_worldspace)
    myWindow.setScreen myScreen
    myWindow.show
end





worldspaceTest
