require 'XY'
describe XY do
  subject {XY.new(0,0)}
  describe "#==" do
    it "compares to another instance of XY usingthe equality operator" do
      expect(subject).to eq XY.new(0,0)
    end
    it "should return false if compared with other objects" do
      expect(subject).not_to eq Array.new
    end
  end
  describe "#copy" do
    it "returns an identical XY" do
      expect(subject.copy).to eq subject
    end
    it "returns an object that can be altered without altering the original XY object" do
      copy = subject.copy
      copy.x = 5
      expect(subject).not_to eq copy
    end
  end
  describe "#to_floats" do
    it "returns a new XY object with the x and y converted to floats" do
      floats = subject.to_floats
      expect(floats.x).to be_instance_of Float
      expect(floats.y).to be_instance_of Float
    end
  end
  describe "#to_integers" do
    it "returns a new XY object with the x and y converted to integers" do
      floats = subject.to_floats
      ints = floats.to_integers
      expect(ints.x).to be_instance_of Integer
      expect(ints.y).to be_instance_of Integer
    end
  end
  describe "#round!" do
    it "rounds the x and y values" do
      subject.x = 2.45674783
      subject.y = 8.233442
      subject.round!(1)
      expect(subject).to eq XY.new(2.5,8.2)
    end
  end

end

describe "pythagoras" do
  it "calculates the distance between two XY points" do
    expect(pythagoras(XY.new(1,1),XY.new(4,5))).to eq 5
  end
end
