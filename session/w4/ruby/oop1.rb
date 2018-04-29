=begin

지역변수(local variable)

- 블록 | 메소드 정의 | 클래스/모듈 정의 | 톱 레벨
- Scope 밖에 있는 지역변수를 참조하면 에러가 발생
- 블록 안이면 블록 밖에서 정의된 지역 변수를 참조 가능
- 반대로 블록안에서 정의된 지역 변수는 블록 밖에서 참여할 수 없다.

인스턴스 변수 설정을 해주지 않으면 오류
=end
class Person
	def initialize(name, age)
		puts name, age
	end

	def run
		# ""안에서 ruby variable을 사용하려면 #{}안에 입력해줘야한다.
		puts "#{name}가 달리고 있습니다."
	end
end

p = Person.new('다혜', 24)
p.run

=begin
아래와 같은 오류 발생

test.rb:8:in `run': undefined local variable or method `name' for #<Person:0x00007fe2e591a918> (NameError)
dahyeui-MacBook-Pro:ruby dh0023$ ruby oop.rb
다혜
24
Traceback (most recent call last):
	1: from oop.rb:14:in `<main>'
oop.rb:9:in `run': undefined local variable or method `name' for #<Person:0x00007fcd718fa778> (NameError)
	
=end

=begin

전역변수($)참고

- 어디에서든 참조 및 변경이 가능한 변수
- 프로그램 규모가 커지면 커질수록 전역 변수가 존재하는 코드는 해석이 어려워진다.
- 정말로 필요한 경우가 아니라면 사용을 자제하는 것이 좋다.
	
end