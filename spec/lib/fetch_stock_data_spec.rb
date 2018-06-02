require 'vcr'
require_relative '../../lib/fetch_stock_data'

describe FetchStockData do
  valid_params = {
    stock_symbol: 'AAPL',
    start_date: '2018-01-01',
    end_date: '2018-01-05'
  }
  invalid_params = {}
  let(:test_fetch) { FetchStockData.new(valid_params) }

  describe 'when initializing' do
    it 'raises argument error with invalid params' do
      stock = FetchStockData.new(invalid_params)
      expect { stock.fetch }.to raise_error(ArgumentError)
    end
  end

  describe "when sending test request" do
    VCR.use_cassette("test_request") do
      it "returns a successful response" do
        expect(test_fetch.test_request['errors']).to be_nil
      end
    end
  end
end
