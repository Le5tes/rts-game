require_relative 'Interface'






loading = lambda {
openScreen = Screen.new
setupScreen = Screen.new
}




loadScreen = Screen.new ([Label.new("Loading",XY.new(100,100))])
rtsMainWindow = new MyWindow (loadScreen)
loading.call
rtsMainWindow.setScreen openScreen
