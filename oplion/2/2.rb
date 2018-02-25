class Person
	@@people_count = 0

	def initialize(name)
		@name = name
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

p = Person.new('성우')
p.run
p.drink
Person.number_of_instances

p2 = Person.new('해인')
p2.run
p2.drink
Person.number_of_instances