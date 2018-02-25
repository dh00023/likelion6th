class Person
	def initialize(name, age)
		@name = name
		@age = age	
	end

	def run
		puts "#{@age}살 #{@name}가 달립니다."
	end

	def check_password(input)
		if input == your_password
			puts "성공적으로 로그인 하셨습니다."
		else
			puts "로그인에 실패하셨습니다."
		end		
	end	
	

	private
	
	def your_password
		@password = "1234567"
	end
end

p = Person.new("다혜",24)
p.run

p.check_password("1234567")
p.check_password("1234")