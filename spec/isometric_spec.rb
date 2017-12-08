require 'isometric'

describe Isometric do
  let(:origin) {double(:origin, x: 0, y: 0)}
  let(:size) {double(:size, x: 5, y: 3)}
  subject {described_class.new(size, origin)}
  describe "#forward" do
	it "converts co-ordinates from a regular grid to isometric arrangement" do
	  expect(subject.forward(0,1){|x,y,z|[x,y,z]}).to eq [5,-3, -1]  
	end
  end
  describe "#backward" do
  	it "converts co-ordinates from isometric arrangement to grid" do
  	  expect(subject.backward(15,9){|x,y| [x,y]}).to eq [3,0]
  	end
  end
end
