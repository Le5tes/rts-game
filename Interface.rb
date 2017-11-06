require 'rubygems'
require 'gosu'
require_relative 'Worldspace'
require_relative 'XY'


class MyWindow < Gosu::Window
def initialize

super 640,480
end
def draw
  @screen.draw
end

def update
  @screen.update
end

def button_down(id)
  if id == Gosu::MS_LEFT || id == Gosu::MS_RIGHT
    @screen.mouse_click(id, mouse_x, mouse_y)
  else
    @screen.button_down(id)
  end
end

def setScreen screen
  @screen = screen
end
end

class Screen

  def initialize (labels = [], buttons = [], worldspace = nil, background = nil)
    @labels, @buttons, @worldspace, @background = labels, buttons, worldspace, background
  end

  def loadFromFile (file)
 #TODO
  end
  def draw
    if @worldspace
       @worldspace.draw
     elsif @background
       @background.draw 0, 0, 0
     end
    @buttons.each {|button| button.draw}
    @labels.each {|label| label.draw}
  end

  def update
    @worldspace.update if @worldspace
  end

  def button_down(id)

  end

  def mouse_click(id, mouse_x, mouse_y)
    if id == Gosu::MS_LEFT
      if (((@buttons.map {|button| button.click(mouse_x, mouse_y) }).sum) == 0) then (@worldspace.click(mouse_x, mouse_y) if @worldspace) end
    end
  end
end
class Label

  def initialize (text, position)
    @text = text
    @xposition = position.x
    @yposition = position.y
  end

  def draw
    Gosu::Font.new(20).draw @text, @xposition, @yposition,0, 1, 1, Gosu::Color::BLACK
  end


end

class Button
  attr_reader :text

  def initialize (text, position, size, &handler)
    @text = text
    @handler = handler
    @xposition = position.x
    @yposition = position.y
    @width = size.x
    @height = size.y

  end

  def draw
    Gosu.draw_rect @xposition, @yposition, @width, @height, Gosu::Color::RED
    Gosu::Font.new(20).draw @text, (@xposition +2), (@yposition +2), 0, 1 , 1, Gosu::Color::BLACK
  end

  def click(x,y)
    if (@xposition <= x && x <= @xposition + @width && @yposition <= y && y <= @yposition + @height)
      @handler.call if @handler
      return 1 #let the caller know a button has been pressed
    end
    return 0
  end


end



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
    map = Array.new(10) {|x| x = Array.new(10) {|x| x = Tile.new(img,1)} }
    #puts map.to_s
    myScreen = Screen.new([],[], WorldSpace.new([],map,XY.new(0,200)))
    myWindow.setScreen myScreen
    myWindow.show
end

worldspaceTest
