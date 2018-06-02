require 'rspec'
require 'vcr'
require_relative '../lib/helpers/dates_helper'

RSpec.configure do |c|
  c.include DatesHelper
end

VCR.configure do |config|
  config.cassette_library_dir = "vcr/cassettes"
  config.hook_into :webmock
end
