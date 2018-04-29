# 초기화
class Person
	def initialize(name, age, sex)
		puts name, age, sex
	end
end

p = Person.new('현경', 23)

=begin
	
초기화 매개변수와 맞지않는 경우의 오류
oop0.rb:2:in `initialize': wrong number of arguments (given 2, expected 3) (ArgumentError)
	
=end