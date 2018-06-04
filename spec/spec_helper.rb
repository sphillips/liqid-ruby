require 'rspec'
require 'vcr'
require_relative '../lib/helpers/dates_helper'

VCR.configure do |config|
  config.cassette_library_dir = "vcr/cassettes"
  config.hook_into :webmock
end
