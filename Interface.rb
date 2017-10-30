require 'rubygems'
require 'gosu'


class Screen < Gosu::Window

  def initialize (labels = [], buttons = [], worldspace = nil, background = nil)
    super 640,480
      @labels, @buttons, @worldspace, @background = labels, buttons, worldspace, background
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

class XY
  attr_accessor :x , :y
  def initialize (x,y)
    @x, @y = x, y
  end
end

######TESTING#####


def basicTest

  testlambda = lambda {
    puts "I do nothing"
  }

  buttons = [Button.new("my button", XY.new(30,50),XY.new(100,30)) do puts "I do nothing" end,Button.new("my other button", XY.new(30,90),XY.new(150,30))]
  myScreen = Screen.new([],buttons)
  myScreen.show
end

basicTest
