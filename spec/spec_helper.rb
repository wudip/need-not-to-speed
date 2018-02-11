require 'bundler/setup'
require 'simplecov'
require 'rspec/simplecov'

SimpleCov.start
SimpleCov.minimum_coverage 95
# RSpec::SimpleCov.start

require_relative '../lib/need_not_to_speed'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.color = true
  config.formatter = :documentation
  config.tty = true
end
