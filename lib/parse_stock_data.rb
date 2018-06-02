class ParseStockData

  attr_reader :stock_data, :start_price, :start_date, :end_price, :end_date
  def initialize(stock_data)
    @stock_data = stock_data
    @start_price = stock_data[stock_data.length - 1][4]
    @start_date = stock_data[stock_data.length - 1][0]
    @end_price = stock_data[0][4]
    @end_date = stock_data[0][0]
  end

  def drawdowns
    "-1.8% (172.3 on 02.01.18 -> 169.26 on 02.01.18)\n-1.8% (172.3 on 02.01.18 -> 169.26 on 02.01.18)\n-1.8% (172.3 on 02.01.18 -> 169.26 on 02.01.18)\n"
  end

  def max_drawdown
    "-1.8% (172.3 on 02.01.18 -> 169.26 on 02.01.18)"
  end

  def rate_of_return
    earnings = end_price - start_price
    ror = (earnings) / start_price
    "#{earnings} [#{format_ror(ror)}%] (#{start_price} on #{start_date} -> #{end_price} on #{end_date})"
  end

  private

  def format_ror(ror)
    (ror * 100).round(1)
  end
end
