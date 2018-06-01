require_relative 'lib/stock'

stock = Stock.new(stock_symbol: ARGV[0], start_date: ARGV[1], end_date: ARGV[2])
stock.output_stock_data
