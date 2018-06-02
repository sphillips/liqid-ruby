gem 'rest-client'
require 'rest-client'
require 'json'

class FetchStockData
  TEST_API_KEY = 'V6qs6uyJLD-MDrz85au4'
  BASE_URL_QUANDL = 'https://www.quandl.com/api/v3/datasets/WIKI/'

  attr_reader :api_key, :stock_symbol, :start_date, :end_date
  def initialize(args={})
    @api_key = ENV['API_KEY'] || TEST_API_KEY
    @stock_symbol = args[:stock_symbol]
    @start_date = args[:start_date]
    @end_date = args[:end_date]
  end

  def quandl_stock_time_data_url
    "#{BASE_URL_QUANDL}#{stock_symbol}.json?order=asc&start_date=#{start_date}&end_date=#{end_date}&api_key=#{api_key}"
  end

  def fetch
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
