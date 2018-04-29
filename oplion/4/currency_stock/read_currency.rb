require 'nokogiri'
require 'rest-client'

url = 'http://finance.naver.com/marketindex/?tabSel=exchange'
page = RestClient.get(url)

# Fetch and parse HTML document
doc = Nokogiri::HTML(page)

info = doc.css('#exchangeList > li.on > a.head.usd > div > span.value').text

p info.delete(',').to_f

