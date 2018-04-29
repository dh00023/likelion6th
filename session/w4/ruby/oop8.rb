# Object의 정보를 읽을 수 있어야하고(read), 쓸 수 있어야한다(write).

# - `attr_reader` : read할 수 있게 해준다.
# - `attr_writer` : write할 수 있게 해준다.
# - `attr_accessor` : read와 write를 할 수 있게 해준다.


class Person

	attr_reader :name, :age
	attr_writer :name, :age
	#attr_accessor :name, :age
	
	def initialize(name, age)
		@name = name
		@age = age
	end
end

#attr_writer : Person#name= 라는 인스턴스 변수가 정의된다.
#attr_reader : Person#name 라는 인스턴스 변수가 정의된다.
#attr_accessor : Person#name , Person#name=라는 인스턴스 변수가 정의된다.