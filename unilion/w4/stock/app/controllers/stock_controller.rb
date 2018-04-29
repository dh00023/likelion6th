class StockController < ApplicationController
	def index
	end

	def get_stock_info
	end

	def show_stock_info
		#inputs = [params[:company1],params[:company2],params[:company3]]
		stock = StockQuote::Stock.quote(params[:company])
		@company = stock.company_name
		@price = stock.latest_price
	end
end
