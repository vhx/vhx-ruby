require 'vhx'
require 'vcr'
require 'json'
require 'test_data'

VCR.configure do |vcr_config|
  vcr_config.cassette_library_dir = 'spec/vcr'
  vcr_config.hook_into :webmock
  vcr_config.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.include TestData
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end