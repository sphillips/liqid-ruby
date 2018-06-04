require_relative 'helpers/dates_helper'
require_relative 'helpers/numbers_helper'

class ParseStockData
  include DatesHelper
  include NumbersHelper

  attr_reader :stock_data, :start_price, :start_date, :end_price, :end_date
  def initialize(stock_data)
    @stock_data = stock_data
    @start_price = stock_data[0][4]
    @start_date = stock_data[0][0]
    @end_price = stock_data[stock_data.length - 1][4]
    @end_date = stock_data[stock_data.length - 1][0]
  end

  def print_closing_prices
    output = "\n"
    stock_data.each { |price_data| output += format_closing_data(price_data) }
    output += "\n"
  end

  def print_drawdowns
    drawdowns = calculate_drawdowns
    output = "First 3 Drawdowns:\n"
    drawdowns.each { |drawdown| output += format_drawdown_data(drawdown) }
    max_drawdown = drawdowns.min_by { |d| d[:amount] }
    output += "Max Drawdown: #{format_drawdown_data(max_drawdown)}\n"
  end

  def print_rate_of_return
    format_ror_data(earnings, ror)
  end

  private

  def earnings
    end_price - start_price
  end

  def ror
    calculate_ror(start_price, end_price)
  end

  # select first 3 records from data and calculate drawdown for each
  def calculate_drawdowns(num = 3)
    drawdowns = []
    stock_data.first(num).each do |price_data|
      date = price_data[0]
      high = price_data[2]
      low = price_data[3]
      drawdown_amount = calculate_drawdown(high, low)

      drawdowns << {
                     amount: format_pct_value(drawdown_amount),
                     date: format_date(date),
                     high_price: high,
                     low_price: low
                   }
    end
    drawdowns
  end

  ###
  # Methods to format data for printing to stdout
  ###

  def format_closing_data(price_data)
    "#{format_date(price_data[0])}: Closed at #{price_data[4].round(2)} (#{price_data[3]} ~ #{price_data[2]})\n"
  end

  def format_drawdown_data(drawdown)
    "#{drawdown[:amount]}% (#{drawdown[:high_price]} on #{drawdown[:date]} -> #{drawdown[:low_price]} on #{drawdown[:date]})\n"
  end

  def format_ror_data(earnings, ror)
    symbol = ror > 0 ? '+' : ''
    "Return: #{earnings} [#{symbol}#{format_pct_value(ror)}%] (#{start_price} on #{format_date(start_date)} -> #{end_price} on #{format_date(end_date)})"
  end
end
