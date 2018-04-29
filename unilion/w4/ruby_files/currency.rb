require 'eu_central_bank'

bank = EuCentralBank.new

# call this before calculating exchange rates
# this will download the rates from ECB
bank.update_rates

# exchange 100 CAD to USD
# API is the same as the money gem
puts bank.exchange(100, "USD", "KRW") # Money.new(80, "USD")
