require 'bundler/setup'
require 'simplecov'
require 'rspec/simplecov'
require 'need_not_to_speed'

SimpleCov.minimum_coverage 95
SimpleCov.start
RSpec::SimpleCov.start

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
