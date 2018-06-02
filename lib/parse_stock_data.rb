class ParseStockData

  attr_reader :stock_data, :start_price, :start_date, :end_price, :end_date
  def initialize(stock_data)
    @stock_data = stock_data
    @start_price = stock_data[stock_data.length - 1][4]
    @start_date = stock_data[stock_data.length - 1][0]
    @end_price = stock_data[0][4]
    @end_date = stock_data[0][0]
  end

  def closing_prices
    puts "\n"
    stock_data.each do |price_data|
      puts "#{format_date(price_data[0])}: Closed at #{price_data[4].round(2)}\n"
    end
    puts "\n"
  end

  def drawdowns
    drawdowns = calculate_drawdowns
    max_drawdown = drawdowns.max_by { |d| d[:amount].abs }
    puts "First 3 Drawdowns:\n"
    drawdowns.each { |drawdown| puts parse_drawdown_data(drawdown) }
    puts "Max Drawdown: #{parse_drawdown_data(max_drawdown)}"
  end

  def rate_of_return
    ror = (earnings) / start_price
    puts "Return: #{earnings} [#{format_ror(ror)}%] (#{start_price} on #{format_date(start_date)} -> #{end_price} on #{format_date(end_date)})"
  end

  private

  def format_date(date_string)
    date = Date.parse(date_string)
    date.strftime("%d.%m.%y")
  end

  def format_ror(ror)
    (ror * 100).round(1)
  end

  def earnings
    end_price - start_price
  end

  def calculate_rate(start_value, end_value)
    amount = (end_value - start_value) / start_value
    format_ror(amount)
  end

  def calculate_drawdowns
    drawdowns = []
    stock_data.each do |price_data|
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

  def parse_drawdown_data(drawdown)
    "#{drawdown[:amount]}% (#{drawdown[:high_price]} on #{drawdown[:date]} -> #{drawdown[:low_price]} on #{drawdown[:date]})\n"
  end
end
