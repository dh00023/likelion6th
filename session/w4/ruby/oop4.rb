# 상속
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
	def kick
		puts "#{@name}이/가 공을 찼습니다."	
	end
end

class BasketballMan < Person
	def shoot
		puts "#{@name}이/가 공을 던졌습니다."	
	end
end

ronaldo = SoccerMan.new('호날두')
ronaldo.run
ronaldo.kick

jordan = BasketballMan.new('조던')
jordan.run
jordan.shoot

=begin
	
호날두이/가 달리고 있습니다.
호날두이/가 공을 찼습니다.
조던이/가 달리고 있습니다.
조던이/가 공을 던졌습니다.
	
=end