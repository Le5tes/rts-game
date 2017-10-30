require 'rubygems'
require 'gosu'


class Screen < Gosu::Window

def draw
  #TODO
end

def update
  #TODO
end

def button_down(id)
if id == Gosu::MS_LEFT
 @buttons.each {|button| button.click(mouse_x, mouse_y) }
end
private
@buttons[]

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
  Gosu.draw_rect @xposition, @yposition, @width, @height, Gosu::Color::RED,
  FONT.draw @text, xposition +2, yposition +2, 1 , 1, Gosu::Color::BLACK
end

def click(x,y)
  if (@xposition <= x && x <= @xposition + @width && @yposition <= y && y <= @yposition + @height)
  @handler.call
  end
end


end
