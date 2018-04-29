# 오버라이딩
class Person
	@@people_count = 0

	def initialize(name)
		@name = name
		@@people_count += 1
	end

	def run
		# ""안에서 ruby variable을 사용하려면 #{}안에 입력해줘야한다.
		puts "#{@name}이/가 달리고 있습니다."
	end

	def drink
		puts "#{@name}이/가 물을 마십니다."
	end
	# self를 붙여줘야 클래스와 관련된 메소드인 것을 확인할 수 있다.
	def self.number_of_instances
		puts "#{@@people_count}명이 생성되었습니다."
	end
end

class SoccerMan < Person
	# 오버라이딩
	def run
		puts "#{@name}가 수비수를 제치면서 달립니다."
	end

	def kick
		puts "#{@name}가 공을 찼습니다."	
	end
end

class BasketballMan < Person
	# 상속 + 기능추가
	# super는 부모 클래스의 메소드를 그대로 가져온다.
	def run
		super
		puts "#{@name}가 드리블을 하면서 달립니다."
	end
	
	def shoot
		puts "#{@name}가 공을 던졌습니다."	
	end
end

ronaldo = SoccerMan.new('호날두')
ronaldo.run
ronaldo.kick

jordan = BasketballMan.new('조던')
jordan.run
jordan.shoot

=begin
	
호날두가 수비수를 제치면서 달립니다.
호날두가 공을 찼습니다.
조던이/가 달리고 있습니다.
조던가 드리블을 하면서 달립니다.
조던가 공을 던졌습니다.
	
=end