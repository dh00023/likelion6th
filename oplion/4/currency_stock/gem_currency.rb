require 'eu_central_bank'

from = 'USD'
to = 'KRW'
bank = EuCentralBank.new

# 시간대 기준으로 업데이트
bank.update_rates

result = bank.exchange(100,from,to)
puts result