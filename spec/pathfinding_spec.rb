require 'pathfinding'

describe "pathfinding" do
	let(:map1) {[
				[true,true,true,false,true,true],
				[true,false,true,false,true,true],
				[true,true,true,false,true,true],
				[true,true,true,false,true,true],
				[true,true,true,false,true,true],
				[true,true,true,false,true,true]
			]}
			
	describe "#fbest_path" do

		it "should return false if the target is out of bounds" do
			a = best_path(XY.new(0,0),XY.new(4,9), map1)
			expect(a).to eq false
		end
		it "should return path to closest square if no path is possible" do
			 a = best_path(XY.new(0,0),XY.new(4,4), map1)
			expect(a.first).to eq XY.new(4,2)
		end
		#for games where the map lists the square the caller is on as occupied
		it "should be able to return a path if the start square is listed as blocked" do 
			a = best_path(XY.new(1,1),XY.new(4,2), map1)
			expect(a.first).to eq XY.new(4,2)
		end
	end

end

