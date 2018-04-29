# public : 모두에게 공개할 수 있는 정보
# private : 공개하면 안되는 정보
# protected : 상속 받은 클래스와 인스턴스
# 객체의 필드, 메소드를 하나로 묶고, 실제 구현 내용을 감추는 것을 말한다.
# 외부 객체는 객체의 내부의 구조를 알지 못하며 객체가 노출해서 제공하는 필드와 메소드만 알 수 있다.
# 필드와 메소드를 캡슐화해서 보호하는 이유는 외부의 잘못된 사용으로 인해 객체가 손상되지 않도록 하기위해서이다.

class Person
	def initialize(name, age)
		@name = name
		@age = age	
	end

	def run
		puts "#{@age}살 #{@name}가 달립니다."
	end

	private
	
	def your_password
		@password = "1234567"
	end
end

p = Person.new('다혜',24)
p.your_password

=begin
	
oop6.rb:25:in `<main>': private method `your_password' called for #<Person:0x00007f8b6010ebe8 @name="다혜", @age=24> (NoMethodError)
	
=end