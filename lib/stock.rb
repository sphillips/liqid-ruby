gem 'rest-client'
require 'rest-client'
require 'json'
require_relative 'parse_stock_data'

class Stock
  TEST_API_KEY = 'V6qs6uyJLD-MDrz85au4'
  BASE_URL_QUANDL = 'https://www.quandl.com/api/v3/datasets/WIKI/'

  attr_reader :api_key, :stock_symbol, :start_date, :end_date

  def initialize(args={})
    @api_key = args[:api_key] || TEST_API_KEY
    @stock_symbol = args[:stock_symbol]
    @start_date = args[:start_date]
    @end_date = args[:end_date]
  end

  def output_stock_data
    stock_data = fetch_stock_data
    print_closing_prices(stock_data)
    print_drawdowns(stock_data)
    print_maximum_drawdown(stock_data)
    print_rate_of_return(stock_data)
  end

  def print_closing_prices(stock_data)
    puts "\n"
    stock_data.each do |price_data|
      puts "#{price_data[0]}: Closed at #{price_data[1].round(2)}\n"
    end
    puts "\n"
  end

  def print_drawdowns(stock_data)
    drawdowns = ParseStockData.new(stock_data).drawdowns
    puts "First 3 Drawdowns:\n#{drawdowns}\n"
  end

  def print_maximum_drawdown(stock_data)
    max_drawdown = ParseStockData.new(stock_data).max_drawdown
    puts "Maximum Drawdown: #{max_drawdown}\n"
  end

  def print_rate_of_return(stock_data)
    ror = ParseStockData.new(stock_data).rate_of_return
    puts "Return: #{ror}"
  end

  def quandl_stock_time_data_url
    "#{BASE_URL_QUANDL}#{stock_symbol}.json?column_index=1&start_date=#{start_date}&end_date=#{end_date}&api_key=#{api_key}"
  end

  def fetch_stock_data
    verify_params
    response = request(quandl_stock_time_data_url)
    response['dataset']['data']
  end

  def request(url)
    RestClient::Request.execute(url: url, method: :get, verify_ssl: false) do |response|
      JSON.parse(response)
    end
  end

  def test_request
    url = "https://www.quandl.com/api/v3/datasets/WIKI/AAPL.json?column_index=4&start_date=2014-01-01&end_date=2014-12-31&api_key=#{api_key}"
    request(url)
  end

  private

  def verify_params
    raise ArgumentError unless valid_params?
  end

  def valid_params?
    !api_key.nil? && !stock_symbol.nil? && !start_date.nil? && !end_date.nil?
  end
end
