require 'date'
require_relative '../../lib/parse_stock_data'

describe ParseStockData do
  include DatesHelper
  stock_data = [
    ["2018-01-02", 170.16, 172.3, 169.26, 172.26, 25048048.0, 0.0, 1.0, 170.16, 172.3, 169.26, 172.26, 25048048.0],
    ["2018-01-03", 172.53, 174.55, 171.96, 172.23, 28819653.0, 0.0, 1.0, 172.53, 174.55, 171.96, 172.23, 28819653.0]
  ]

  let!(:parse_data) { ParseStockData.new(stock_data)}

  it "formats closing prices correctly" do
    # expect(parse_data.print_closing_prices).to eq("02.01.18: Closed at 172.26 (169.26 ~ 172.3)")
  end

  it "formats drawdowns correctly" do

  end

  it "formats rate of return correctly" do
    expect(parse_data.print_rate_of_return).to eq("Return: -0.030000000000001137 [-0.0%] (172.26 on 02.01.18 -> 172.23 on 03.01.18)")
  end
end
