# 외부에서 인스턴스 변수에 접근하려면 별도의 메소드를 정의해야한다.
class Person
    def name=(val)
        @name = val
    end
    
    def name
        @name
    end
end

p = Person.new
p.name = "다혜"
puts p.name

# 설명을 위해서 메소드를 정의했으나 실제로는 `attr_accessor`를 이용한다.