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
    tank = Unit.new(XY.new(3,2),  Model.new([tankimg],XY.new(0,0)))
    tank2 = Unit.new(XY.new(3,3),  Model.new([tankimg],XY.new(0,0)))
    player = Player.new([tank, tank2])
    #puts map.to_s
    myScreen = Screen.new([],[], WorldSpace.new({testplayer: player},map,XY.new(0,200)))
    myWindow.setScreen myScreen
    myWindow.show
end

worldspaceTest
