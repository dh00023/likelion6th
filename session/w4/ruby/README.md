# Ruby

## 1. OOP(객체 지향 프로그래밍)

- 객체(Object) : 대상, 즉 현실에 존재하는 무언가 / 사물
	- 변수 : 정보
	- 함수(Method) : 행위
- 지향 : 목표 / 가리키는 것
- 프로그래밍 : 컴퓨터 프로그램을 작성하는 것

객체 지향 프로그래밍은 현실의 무언가를 컴퓨터 프로그램으로 만드는 것이다.

#### Object를 만드는 이유?
정보/행위를 가진 현실의 것을 재창조하는 것이다.

```ruby
Person.run()
```

#### 하나의 **기준** + 기준의 적용

- Object
	- Class(반, 분류)
	- Instance(구체적인 예)

각기 다른 정보(변수) + 같은 행위(함수) + 다른 결과

코드의 **재활용**과 **중복의 제거**를 할 수 있다.

## 2. Class and Instance

```ruby
string1 = String.new('like')
puts string1 

string2 = String.new('lion')
puts string2 

#=> like
#=> lion

# 함수 사용하기

puts string1.reverse
puts string2.reverse

#=> ekil
#=> noil
```

#### 루비파일 실행하기
```
$ ruby 2.rb
```

나만의 클래스를 만드려면? 1. **변수** 2. **함수(메소드)**
메소드와 함수는 비슷한 의미로 사용된다.

#### initialize : 초기화

```ruby
class Person
	def initialize(name, age, sex)
		puts name, age, sex
	end
end

p = Person.new('성우', 24, '남자')
```
- `initialize`함수가 없으면 생기는 오류
```
$ 2.rb:7:in `initialize': wrong number of arguments (given 3, expected 0) (ArgumentError)
```

#### method의 구현

- 인스턴스 변수 `@` : 인스턴스 안에 소속된 모든 메소드 안에서 활용 가능한 변수이다. (메소드 밖에서 사용 불가)

```rb
class Person
	def initialize(name)
		puts name
	end

	def run
		# ""안에서 ruby variable을 사용하려면 #{}안에 입력해줘야한다.
		puts "#{name}가 달리고 있습니다."
	end
end

p = Person.new('성우')
p.run
```
인스턴스 변수를 설정해주지 않아서
```
$ 2.rb:8:in `run': undefined local variable or method `name' for #<Person:0x00007fd2f982e7f8> (NameError)
```
와 같은 오류가 난다.

```rb
class Person
	def initialize(name)
		@name = name
	end

	def run
		# ""안에서 ruby variable을 사용하려면 #{}안에 입력해줘야한다.
		puts "#{@name}가 달리고 있습니다."
	end
end

p = Person.new('성우')
p.run
```

- 클래스 변수 `@@` : **클래스 안** 전체에서 사용 가능한 변수이다. 인스턴스 변수의 범위를 포함한다.(메소드 밖에서도 사용 가능)

```rb
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
```

## 3. 상속(Inheritance)

```rb
class SoccerMan < Person
	
	def kick
		puts "#{@name}가 공을 찼습니다."	
	end
end

class BasketballMan < Person
	
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
```

#### 메소드 변경
1. 상속거부하기
```rb
class SoccerMan < Person
	# 상속 거부
	def run
		puts "#{@name}가 수비수를 제치면서 달립니다."
	end

	def kick
		puts "#{@name}가 공을 찼습니다."	
	end
end
```
2. 상속받기 + 기능 추가하기
```rb

class BasketballMan < Person
	# 상속 + 기능추가
	def run
		super
		puts "#{@name}가 드리블을 하면서 달립니다."
	end
	
	def shoot
		puts "#{@name}가 공을 던졌습니다."	
	end
end
```

** 두 개 이상의 상속은 불가능하다. **

## 4. Public / Private

- public : 공개할 수 있는 정보
- private : 공개하면 안되는 정보

```rb
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
```

```
$ 4.rb:20:in `<main>': private method `your_password' called for #<Person:0x00007ff00f9222f8 @name="다혜", @age=24> (NoMethodError)
```
`private`에 있는 method를 호출하면 함수밖에서 실행할 수 없다.

## 5. attr_accessor

Object의 정보를 읽을 수 있어야하고(read), 쓸 수 있어야한다(write).

- `attr_reader` : read할 수 있게 해준다.
- `attr_writer` : write할 수 있게 해준다.
- `attr_accessor` : read와 write를 할 수 있게 해준다.

```rb
class Person

	attr_reader :name
	attr_writer :age
	
	def initialize(name, age)
		@name = name
		@age = age
	end

	def name
		@name
	end

	def age
		@age
	end

	def name=(input)
		@name = input
	end

	def age=(input)
		@age = input
	end
end
```
```rb
class Person

	attr_reader :name, :age
	attr_writer :name, :age
	
	def initialize(name, age)
		@name = name
		@age = age
	end
end
```
```rb
class Person

	attr_accessor :name, :age
	
	def initialize(name, age)
		@name = name
		@age = age
	end
end
```

## 6. ORM(Object-Relational Mappers)

#### SQL(Structured Query Language)
- 데이터베이스와 작업을 하고 싶을 때 쓰는 언어
- SQL DB는 관계형(relational) DV
- PostgresSQL, MySQL 등등

```sql
SELECT * FROM users WHERE name="lion" ORDER_BY created_at
```

#### Rails ORM

SQL을 간편하게 사용하기위한 개념
즉, 우리가 루비로 쓰면, 레일즈가 SQL로 번역해준다.

```rb
User.where(name:"lion").order("created_at")
```

#### Active Record
Rails에서 사용하는 ORM프레임워크