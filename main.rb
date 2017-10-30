require 'Assets'
require 'Worldspace'
require 'Interface'





loading = lambda {
openScreen = Screen.new
setupScreen = Screen.new
}




loadScreen = Screen.new ([Label.new("Loading",XY.new(100,100))])
loadScreen.show
loading.call
openScreen.show
