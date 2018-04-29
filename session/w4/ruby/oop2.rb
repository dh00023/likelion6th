# 인스턴스 변수
# 인스턴스 내에서만 참조할 수 있는 변수
# 객체의 상태를 저장할 수 있다. 
# 외부에서 인스턴스 변수에 접근하려면 별도의 메소드를 정의해야 함

class Person
	def initialize(name, age)
		@name = name
		@age = age
	end

	def run
		# ""안에서 ruby variable을 사용하려면 #{}안에 입력해줘야한다.
		puts "#{@name}가 달리고 있습니다."
	end
end

p = Person.new('다혜', 24)
p.run

#=>다혜가 달리고 있습니다.