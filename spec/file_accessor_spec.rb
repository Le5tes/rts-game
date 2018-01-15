require 'file_accessor'
require 'Worldspace'

describe FileAccessor do 
let(:my_class) {double(:a_class, new: my_object)}
let(:my_object) {double(:an_object)}

let(:my_file) {double(:file)}

TestConst = nil

  # describe "#feature_test_load" do
  # 	require 'Assets'
  # 	p FileAccessor.new.load "/Users/tim/Documents/Projects/RTS/rts-game/data/default_tank"
  # end
  describe "#save" do
  	it "creates a file containing the information required to initialize an object" do

  	end
  end

  describe "#read" do
  	it "takes an array of strings and returns a hash of parameter_name => value" do
  	 lines = [
  	 	"Class1",
  	  	"name Tim",
  	  	"age 150",
  	  	"",
  	  	" ",
  	  	"this {",
  	  	"Class2",
  	  	"another thing",
  	  	"it is",
  	  	"}",
  	  	"thats all"
  	  ]

  	  expect(subject.read(lines)).to eq([:Class1,{name: "Tim", age: "150", this: [:Class2,{another: "thing", it: "is"}],  thats: "all"}])
  	end
  end

  describe "#build_class" do
  	it "takes a class name as a string or symbol and a set of parameters and creates a new instance of that class, passing the parameters" do
  		parameters = {example: :parameter}
  		expect(TestConst).to receive(:new).with(parameters)
  		subject.build_class(:TestConst, parameters)
  	end
    it 
  end


  describe "#get_parameter" do
  	it "splits a string into a parameter name and value as an array" do
  	  expect(subject.get_parameter("number 45")).to eq([:number, "45"])
  	end
  end	
end