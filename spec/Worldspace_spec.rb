require 'Worldspace'

describe WorldSpace do
	let(:p1asset) { double(:p1asset) }
	let(:p2asset) { double(:p2asset) } 

	let(:player1) { double(:player1,assets: {asset1: p1asset, asset2: p1asset} ) }
	let(:player2) { double(:player2,assets: {asset1: p2asset, asset2: p2asset} ) }

	subject { described_class.new({player1: player1, player2: player2}) }

  describe "#assets" do
  	it "should return an array containing a number of arrays of the form [key, asset, player]" do
  	  
  	  expect(subject.assets).to eq [ p1asset, p1asset, p2asset, p2asset]
  	end
  end
end