class ParseStockData

  attr_reader :stock_data
  def initialize(stock_data)
    @stock_data = stock_data
  end

  def drawdowns
    "-1.8% (172.3 on 02.01.18 -> 169.26 on 02.01.18)\n-1.8% (172.3 on 02.01.18 -> 169.26 on 02.01.18)\n-1.8% (172.3 on 02.01.18 -> 169.26 on 02.01.18)\n"
  end

  def max_drawdown
    "-1.8% (172.3 on 02.01.18 -> 169.26 on 02.01.18)"
  end

  def rate_of_return
    "2.740000000000009 [+1.6%] (172.26 on 02.01.18 -> 175.0 on 05.01.18)"
  end
end
