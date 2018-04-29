require 'stock_quote'
require 'eu_central_bank'


print "원하는 NASDAQ 주식의 심볼을 입력하세요 : "
input = gets.chomp
puts input
stock = StockQuote::Stock.quote(input)

bank = EuCentralBank.new
bank.update_rates


res = bank.exchange(stock.latest_price*100, "USD", "KRW") 
puts "#{stock.company_name}의 가격은 #{res}"