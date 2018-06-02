require 'date'
require_relative '../../lib/parse_stock_data'

describe ParseStockData do
  stock_data = [
    ["2018-01-02", 170.16, 172.3, 169.26, 172.26, 25048048.0, 0.0, 1.0, 170.16, 172.3, 169.26, 172.26, 25048048.0],
    ["2018-01-03", 172.53, 174.55, 171.96, 172.23, 28819653.0, 0.0, 1.0, 172.53, 174.55, 171.96, 172.23, 28819653.0]
  ]

  let!(:parse_data) { ParseStockData.new(stock_data)}

  it "formats closing prices correctly" do
    expect(parse_data.print_closing_prices).to eq("\n02.01.18: Closed at 172.26 (169.26 ~ 172.3)\n03.01.18: Closed at 172.23 (171.96 ~ 174.55)\n\n")
  end

  it "formats drawdowns correctly" do
    expect(parse_data.print_drawdowns).to eq("First 3 Drawdowns:\n-1.8% (172.3 on 02.01.18 -> 169.26 on 02.01.18)\n-1.5% (174.55 on 03.01.18 -> 171.96 on 03.01.18)\nMax Drawdown: -1.8% (172.3 on 02.01.18 -> 169.26 on 02.01.18)\n")
  end

  it "formats rate of return correctly" do
    expect(parse_data.print_rate_of_return).to eq("Return: -0.030000000000001137 [-0.0%] (172.26 on 02.01.18 -> 172.23 on 03.01.18)")
  end
end
