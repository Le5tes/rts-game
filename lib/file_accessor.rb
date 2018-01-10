class FileAccessor
  def load(filepath)
   p File.path(__FILE__)
  	File.open(filepath, 'r'){|file|
  	data = read(file.readlines)
  	build_class(data[0],data[1])
  	}
  end

  def read lines
    p "here"
  	myclass = get_class(lines.first)
    p myclass
  	parameters = []
  	while !lines.empty? do
  	  line = lines.shift
      p line
  	  return [myclass,parameters.compact.to_h]if is_closing_brace?(line)
  	  parameter = get_parameter(line)
      p parameter
  	  parameter[1] = read lines if parameter && (parameter[1] == "{")
  	  parameters << parameter
  	end
  	p([myclass,parameters.compact.to_h])
  end

  def get_parameter(line)
  	x = line.scan(/([a-z,_]+) (\S+)/)[0]
    p x
 	(x[0] = x[0].to_sym) if x
 	x
  end

  def is_closing_brace?(line)
  	line.chomp == "}"
  end

  def get_class(line)
  	x = line.scan(/((?<!\s)[A-Z]\w+)/)[0]
  	x[0].to_sym if x
  end

  def build_objects_in parameters
    # p "parameters = " + parameters.to_s
  	parameters = parameters.map{|name, parameter|
      # p parameter
      # p (parameter.is_a? Array) ? "is and array" : "isn't an array"

  	  [name,((parameter.is_a? Array) ? build_class(parameter[0], parameter[1]) : parameter)]
  	}.to_h
  end 

  def build_class(class_name, parameters)
  	build_objects_in parameters
    p parameters
  	Object.const_get(class_name).new(parameters)
  end
end