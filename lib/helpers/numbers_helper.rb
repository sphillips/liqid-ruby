module NumbersHelper
  # format as percent, rounded to 1 decimal place
  def format_ror_value(ror)
    (ror * 100).round(1)
  end
end
