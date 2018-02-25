class Person

	attr_reader :name, :age
	attr_writer :age, :name
	
	def initialize(name, age)
		@name = name
		@age = age
	end
end

person = Person.new("정다혜",24)
puts person.name, person.age