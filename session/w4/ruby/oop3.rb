# @@class변수
# 클래스와 해당 인스턴스를 범위로 하는 변수
# 클래스 변수는 클래스 정의 안이나 클래스 메소드에서 참조할 수 있다.
# 클래스 변수는 서브 클래스, 클래스 메소드, 인스턴스 메소드에서 공개할 수 있는 변수

class Person
	@@people_count = 0

	def initialize(name,age)
		@name = name
		@age = age
		@@people_count += 1
	end

	def run
		# ""안에서 ruby variable을 사용하려면 #{}안에 입력해줘야한다.
		puts "#{@name}가 달리고 있습니다."
	end

	def drink
		puts "#{@name}가 물을 마십니다."
	end
	# self를 붙여줘야 클래스와 관련된 메소드인 것을 확인할 수 있다.
	def self.number_of_instances
		puts "#{@@people_count}명이 생성되었습니다."
	end
end

p = Person.new('현경',23)
p.run
p.drink
# class변수와 메소드는 Class명으로 접근 가능하다.
Person.number_of_instances

p2 = Person.new('현진',23)
p2.run
p2.drink
Person.number_of_instances

=begin
현경가 달리고 있습니다.
현경가 물을 마십니다.
1명이 생성되었습니다.
현진가 달리고 있습니다.
현진가 물을 마십니다.
2명이 생성되었습니다.
=end