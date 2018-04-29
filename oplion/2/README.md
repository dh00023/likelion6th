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


## Class

### 정의

```ruby
class NewClass
end
```
```ruby
class NewClass; end
```

* 클래스 명은 영문 대문자로 시작해야한다.
### 인스턴스

* (인스턴스) 메소드 = 클래스 정의 내에 정의한 메소드는 해당 클래스의 **인스턴스**로 호출될 수 있다. 
```ruby
class Myclass
    def hello
      puts 'Hello'
    end
end
```

- 인스턴스 생성 / 호출

```ruby
클래스명.new
my_object = Myclass.new
my_object.hello
```

* class는 상속하거나 상속 될 수 있다.
루비는 기본형이 존재하지 않고 모든 것이 객체이다. 

```ruby
p 1.to_s
#=> "1"

p true.to_s
#=> "true"
```

1과 같은 숫자나 true/false와 같은 진릿 값도 객체이다. 객체이기 때문에 메소드도 호출 할 수 있다.

```ruby
p 'hello'.class
#=> String
p String.ancestors
#=> [String, Comparable, Object, Kernel, BasicObject]
p 10.class
#=> Integer
Integer.ancestors
#=> [Integer, Numeric, Comparable, Object, Kernel, BasicObject]
p true.class
#=> TrueClass
TrueClass.ancestors
#=> [TrueClass, Object, Kernel, BasicObject]
```

문자열, 수치 뿐만 아니라 true/false, nil과 같은 객체에도 클래스가 존재한다. Object의 클래스의 자식 관계로 구성된다.

BasicObject가 최상위 클래스이다.



### 변수와 상수

#### 지역변수

스코프(참조 가능 범위)가 가장 좁은 종류의 변수다. 지역 변수명은 `ruby`나 `_ruby`처럼 첫글자는 소문자 영어 또는 언더바여야한다.

- 블록
- 메소드 정의
- 클래스/모듈 정의
- 톱 레벨

스코프 밖에 있는 지역변수를 참조하면 에러가 발생한다. 블록 안이면 블록 밖에서 정의된 지역 변수를 참조할 수 있지만, 반대로 블록안에서 정의된 지역 변수는 블록 밖에서 참여할 수 없다.

```ruby
greeting = "Hello, "
people = %w[다혜 현경 현진]

people.each do |p|
	puts greeting + p
end
#=> Hello, 다혜
#=> Hello, 현경
#=> Hello, 현진

puts p
#=> nil
```

#### 전역변수($)

어디에서든 참조 및 변경이 가능한 변수이다. 프로그램 규모가 커지면 커질수록 전역 변수가 존재하는 코드는 해석이 어려워진다.

정말로 필요한 경우가 아니라면 사용을 자제하는 것이 좋다.

```ruby
$lion = "like"
$undefined
#=> nil
```

`$undefined`와 같이 존재하지 않는 전역변수를 참조하면 `nil`이 반환된다.

#### 인스턴스 변수(@)

 인스턴스 내에서만 참조할 수 있는 변수이다. 이것을 사용해서 객체의 상태를 저장할 수 있다. 외부에서 인스턴스 변수에 접근하려면 별도의 메소드를 정의해야한다.

```ruby
# setter
class Ruler
    def length=(val)
        @length = val
    end
    
    def length
        @length
    end
end

ruler = Ruler.new

ruler.length = 30
ruler.length
```

설명을 위해서 메소드를 정의했으나 실제로는 `attr_accessor`를 이용한다.

```ruby
class Ruler
    attr_accessor :length
end
```

를 하면 Ruler#length=라는 인스턴스 변수가 정의된다.



#### 클래스 변수(@@)

클래스와 해당 인스턴스를 범위로 하는 변수이다.

클래스 변수는 클래스 정의 안이나 클래스 메소드에서 참조할 수 있다.

```ruby
class MyClass
    @@cvar = 'class variable'
    
    def cvarin
        puts @@cvar
    end
    def self.cvarin_class
        puts @@cvar
    end
end
```



### self

self는 인스턴스를 참조한다. 메소드 내부에서 receiver를 생략하면 default로 self가 리시버가 된다.

```ruby
class Ruler
    attr_accessor :length
    def set_default_length
        self.length = 30
        #self를 생략하면 length라는 지역변수가 선언됨
    end
end
```

### 초기화(생성자)

인스턴스를 생성할 때 인스턴스 초기화가 필요한 경우가 있다. 이때 `initialize` 메소드를 정의하면 된다.

```ruby
class Car
  def initialize(make, model)
    @make = make
    @model = model
  end
end
```
- Create an instance of class .new

```ruby
kitt = Car.new("Pontiac", "Trans Am")
```



### 클래스 메소드

클래스 메소드는 메소드명 앞에 `self`를 붙여서 정의한다.

```ruby
class Ruler
    attr_accessor :length
    def self.pair
		[Ruler.new, Ruler.new]
    end
end

Ruler.pair
#=> [#<Ruler:0x00007ff8530e86b8>, #<Ruler:0x00007ff8530e8690>]
```

클래스 메소드 안에 있는 self는 해당 메소드가 속해 있는 클래스를 가리킨다. 클래스 메소드는 클래스 명으로 접근 할 수 있다.



### Inheritance (상속) `<`
```ruby
class 서브 클래스 < 슈퍼 클래스명
  # Some stuff!
end
```
`<`말고도 `Class.new`에서는 인수에 상속하고 싶은 부모 클래스를 지정하면 된다.
```ruby
SecondClass=Class.new(FirstClass) 
#==> secondclass(자식 클래스)
SecondClass.superclass
#==> firstclass(부모 클래스)
```
상속된 함수나 변수를 override할 수 있다.
```ruby
class Creature
  def initialize(name)
    @name = name
  end
  
  def fight
    return "Punch to the chops!"
  end
end

class Dragon<Creature
   # 오버라이딩
    def fight
        return "Breathes fire!"
    end
end
```

#### 오버라이드

super 클래스에서 이미 정의된 메소드를 sub 클래스에서 다시 정의하는 것을 메소드 오버라이드라고한다.

#### `super` 

super는 부모클래스(super class)에 정의되어있는 initialize, 메소드를 호출할 수 있다.
```ruby
class DerivedClass < Base
  def some_method
    super(optional args)
      # Some stuff
    end
  end
end
```

### Public and Private

* `public` : allow for an interface with the rest of the program( This method can be called from outside the class )
* `private` : for your classes to do their own work undisturbed( This method can't!)
```ruby
class ClassName
  	# Some class stuff
  	public
  	# Public methods go here
  	def public_method; end

  	private
  	# Private methods go here
  	def private_method; end
end 
```

### `attr_reader` / `attr_writer` /`attr_accessor`

* `attr_reader` : to access a variable
* `attr_writer` : to change it
* `attr_accessor` : to make a variable readable and writeable in one fell swoop
```ruby
class Person

	attr_reader :name
	attr_writer :name
  	
    def initialize(name)
    	@name = same
    end
end
```
```ruby
def name
	@name
end
def name=(value)
	@name = value
end
```
That `name=`  allowed to put an = sign in a method name. 
- - -
