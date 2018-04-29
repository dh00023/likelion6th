# W4 

## Ruby 주식정보 가져오기

#### ruby gem[[rubygems.org](rubygems.org)]

gem은 루비로 쓰여있는 코드 덩어리라 생각하면된다. 특정 기능들을 하는 코드 덩어리!

- [Gem stock_quote](https://github.com/tyrauber/stock_quote)

```bash
$ gem install stock_quote
```

gem이 동작하기 위해서는 다른 gem이 필요하다! 기존에 존재하는 gem들을 활용해서 만들어져있다.

```bash
# gem 설치된 애들 확인하기
$ gem list
```

- 기업(symbol)의 주식 정보가져오기

```ruby
require('stock_quote')
stock = StockQuote::Stock.quote("symbol")
# 애플
stock = StockQuote::Stock.quote("aapl")
puts stock
#=> #<StockQuote::Stock:0x00007fe1d1020e30>
```

```ruby
#<StockQuote::Stock:0x00007fb1743f67b8 @symbol="AAPL", @company_name="Apple Inc.", @primary_exchange="Nasdaq Global Select", @sector="Technology", @calculation_price="close", @open=164.07, @open_time=1524835800489, @close=162.32, @close_time=1524859200408, @high=164.33, @low=160.63, @latest_price=162.32, @latest_source="Close", @latest_time="April 27, 2018", @latest_update=1524859200408, @latest_volume=35610298, @iex_realtime_price=nil, @iex_realtime_size=nil, @iex_last_updated=nil, @delayed_price=162.49, @delayed_price_time=1524862794217, @previous_close=164.22, @change=-1.9, @change_percent=-0.01157, @iex_market_percent=nil, @iex_volume=nil, @avg_total_volume=33151296, @iex_bid_price=nil, @iex_bid_size=nil, @iex_ask_price=nil, @iex_ask_size=nil, @market_cap=823613790160, @pe_ratio=16.68, @week52_high=183.5, @week52_low=142.2, @ytd_change=-0.05386146578029324, @attribution="Data provided for free by IEX (https://iextrading.com/developer).", @response_code=200>
```

```ruby
# 최근 가격 가져오기
puts stock.latest_price
```

```ruby
#여러개 정보가져오기
require('stock_quote')
stock = StockQuote::Stock.quote("amzn, tsla, aapl, fb, googl")
stock.each do |p|
	puts p.company_name, p.latest_price
end
```

#### 사용자의 입력을 받아서 주색 검색하기

```ruby
require('stock_quote')

print "원하는 NASDAQ 주식의 심볼을 입력하세요 : "
input = gets.chomp
puts input
stock = StockQuote::Stock.quote(input)
puts stock.company_name, stock.latest_price
```

- puts는 `\n`붙어서! print는 그대로 출력

### $를 원화로 바꾸기

#### ruby gem[[eu_central_bank](https://github.com/RubyMoney/eu_central_bank)]

```bash
$ gem install eu_central_bank
```

### Gemfile을 이용해서 gem file 한번에 설치하기

```bash
# bundler를 이용해서 한다!
$ gem install bundler
```

```bash
$ vim Gemfile
```

```bun
source "https://rubygems.org/"
# 주식시세
gem stock_quote
# 환율
gem eu_central_bank
```

```bash
$ bundle install
# Gemfile.lock 파일생성
#=>이 파일은 gem들이 서로 엉키지않게 해준다.
```

```ruby
require 'eu_central_bank'

bank = EuCentralBank.new

# call this before calculating exchange rates
# this will download the rates from ECB
bank.update_rates

# exchange 100 CAD to USD
# API is the same as the money gem
puts bank.exchange(100, "USD", "KRW") # Money.new(80, "USD")
```



### 두개 합치기

```ruby
require 'stock_quote'
require 'eu_central_bank'


print "원하는 NASDAQ 주식의 심볼을 입력하세요 : "
input = gets.chomp
puts input
stock = StockQuote::Stock.quote(input)

bank = EuCentralBank.new
bank.update_rates


res = bank.exchange(stock.latest_price*100, "USD", "KRW") 
print stock.company_name
puts res
```



#### 레일즈에서 정보가져오기

```
# Gemfile
gem stock_quote
```

```ruby
# stock_controller
class StockController < ApplicationController
	def index
	end

	def get_stock_info
	end

	def show_stock_info
		stock = StockQuote::Stock.quote(params[:company])
        @company = stock.company_name
		@price = stock.latest_price
	end
end
```

```ruby
#routes
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'stock#index'
  get 'stock/get_stock_info'=>'stock#get_stock_info'
  get 'stock/show_stock_info'=>'stock#show_stock_info'
end

```

```erb
<p>원하는 NASDAQ 주식의 심볼을 입력하세요 : </p>
<form action="/stock/show_stock_info">
	Symbol입력: <input type="text" name="company" placeholder="fb, amzn, aapl, tsla.."><br>
  <input type="submit" value="Submit">
</form>
```

보내는건 form 태그 받는건 params!

## MODEL

- DataBase : 체계화된 데이터의 묶음
- DBMS : DB내의 데이터를 접근할 수 있도록 해주는 소프트웨어 도구의 집합
- SQL(Structed Query Langage) : RDBMS(관계형)의 데이터를 관리하기 위해 설계된 특수 목적 언어
- Rails에서는 SQL사용안해! 어떻게 가능해?
  - 이게 바로 Model이 하는일



0. 모델 생성하기(Model, Table)
1. Table구조 잡기(Column 구성 / attribute)
2. 테이블 생성
3. 데이터 생성(Row / 튜플 / 레코드)
4. 데이터 채워넣고
5. 저장

#### 모델 생성하기

모델은 생성할 때 단수로 생성해야한다.

```bash
$ rails g model member
      invoke  active_record
      create    db/migrate/20180429111133_create_members.rb
      create    app/models/member.rb
      invoke    test_unit
      create      test/models/member_test.rb
      create      test/fixtures/members.yml
```

단수로 생성하면 자동으로 s가 붙어서 복수형으로 바뀐다.

마이그레이션 파일 내에서 테이블의 구조를 잡는 것이다.

```ruby
#  db/migrate/20180429111133_create_members.rb
class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
    	t.string :name
    	t.string :email
    	t.integer :age
    	t.boolean :married
    	
      t.timestamps
    end
  end
end
```

테이블 생성

```bash
$ rails db:migrate
== 20180429111133 CreateMembers: migrating ====================================
-- create_table(:members)
   -> 0.0010s
== 20180429111133 CreateMembers: migrated (0.0011s) ===========================
```

#### gem rails_db

```
gem 'rails_db'
```

```
http://localhost:3000/rails/db
```

에서 생성된 테이블을 확인할 수 있다.

#### rails c(onsole)

```ruby
irb(main):001:0> m = Member.new
=> #<Member id: nil, name: nil, email: nil, age: nil, married: nil, created_at: nil, updated_at: nil>
irb(main):002:0> m.name = "dahye"
=> "dahye"
irb(main):003:0> m.email = "dh0023@likelion.org"
=> "dh0023@likelion.org"
irb(main):004:0> m.married = false
=> false
irb(main):005:0> m.age = 24
=> 24
irb(main):006:0> m.save

```

id는 전체에 하나밖에 없다.(key값)

```ruby
#id값으로 접근하기
Member.find(1)
```

save를 해야 정보가 저장된다.