# frozen_string_literal: true

require "retell/sdk/unofficial"

BASE_URL = ENV['TEST_API_BASE_URL'] || 'http://127.0.0.1:4010'
API_KEY = 'YOUR_RETELL_API_KEY'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    unless ENV['TEST_API_BASE_URL'] || system('curl --silent "http://localhost:4010" > /dev/null 2>&1')
      system('ruby scripts/mock.rb --daemon')
      at_exit { system('kill $(lsof -t -i:4010)') }
    end
  end

  config.before(:each) do
    @client = Retell::SDK::Unofficial.new(base_url: BASE_URL, api_key: API_KEY)
  end
end
