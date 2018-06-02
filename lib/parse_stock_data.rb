require_relative 'helpers/dates_helper'

class ParseStockData
  include DatesHelper

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
    ror = (earnings) / start_price
    format_ror_data(earnings, ror)
  end

  private

  def format_ror_value(ror)
    (ror * 100).round(1)
  end

  def earnings
    end_price - start_price
  end

  # calculate ROR value, format as percent and round to 1 decimal place
  def calculate_rate(start_value, end_value)
    amount = (end_value - start_value) / start_value
    format_ror_value(amount)
  end

  # select first 3 records from data and calculate drawdown for each
  def calculate_drawdowns
    drawdowns = []
    stock_data.first(3).each do |price_data|
      high = price_data[2]
      low = price_data[3]
      drawdowns << {
                     amount: calculate_rate(high, low),
                     date: format_date(price_data[0]),
                     high_price: high,
                     low_price: low
                   }
    end
    drawdowns
  end

  # methods to format data for printing to stdout

  def format_closing_data(price_data)
    "#{format_date(price_data[0])}: Closed at #{price_data[4].round(2)} (#{price_data[3]} ~ #{price_data[2]})\n"
  end

  def format_drawdown_data(drawdown)
    "#{drawdown[:amount]}% (#{drawdown[:high_price]} on #{drawdown[:date]} -> #{drawdown[:low_price]} on #{drawdown[:date]})\n"
  end

  def format_ror_data(earnings, ror)
    symbol = ror > 0 ? '+' : ''
    "Return: #{earnings} [#{symbol}#{format_ror_value(ror)}%] (#{start_price} on #{format_date(start_date)} -> #{end_price} on #{format_date(end_date)})"
  end
end
