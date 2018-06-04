module NumbersHelper
  # rate of return
  def calculate_ror(start_value, end_value)
    (end_value - start_value) / start_value
  end

  def calculate_drawdown(high, low)
    (low - high) / low
  end

  # format decimal as percent, rounded to 1 decimal place
  # 0.740000000000009 => 74.0
  def format_pct_value(ror)
    (ror * 100).round(1)
  end
end
