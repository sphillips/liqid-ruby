require_relative 'fetch_stock_data'
require_relative 'parse_stock_data'

class Stock
  attr_reader :args

  def initialize(args={})
    @args = args
  end

  def output_stock_data
    stock_data = FetchStockData.new(args).fetch
    parsed_stock_data = ParseStockData.new(stock_data)
    parsed_stock_data.print_closing_prices
    parsed_stock_data.print_drawdowns
    parsed_stock_data.print_rate_of_return
  end
end
