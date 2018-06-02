require 'rspec'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "vcr/cassettes"
  config.hook_into :webmock
end
