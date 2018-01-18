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
def needs_cursor?
  true
end
end

class Screen

  def initialize (labels = [], buttons = [], worldspace = nil, background = nil, sidebar = SideBar.new)
    @labels, @buttons, @worldspace, @background, @sidebar = labels, buttons, worldspace, background, sidebar
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
    @worldspace.update if @worldspace  ##worldspace should have it's own update schedule I think, this may turn to viewport.update?
  end

  def button_down(id)

  end

  def mouse_click(id, mouse_x, mouse_y)
    if id == Gosu::MS_LEFT
      if ((@buttons.map {|button| button.click(mouse_x, mouse_y) }).sum) == 0
        if @worldspace 
          if (asset = @worldspace.click(mouse_x, mouse_y)).is_a? Asset 
            # @sidebar.draw asset
          end 
        end
      end
    end
  end
end
class SideBar
  INDENTATION = 10
  ZPOSITION = 1000
  def draw asset, xy
    asset.draw(xy.x+INDENTATION, xy+ INDENTATION, ZPOSITION)
    asset.created_assets.each_with_index {|asset, i| }
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
