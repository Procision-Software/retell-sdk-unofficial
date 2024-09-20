# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'net/http'
require 'uri'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

# Taken from https://github.com/RetellAI/retell-python-sdk/blob/main/.stats.yml
DEFAULT_URL = 'https://storage.googleapis.com/stainless-sdk-openapi-specs/retell%2Ftoddlzt-1977a3acba309ac46a04585e309033b92f7c940963f370bf18b1357cd4aee67a.yml'

desc 'Fetch OpenAPI specification and save to openapi.yml'
task :fetch_api_spec, [:url] do |t, args|
  url = args[:url] || DEFAULT_URL
  uri = URI(url)

  puts "Fetching OpenAPI specification from #{url}"

  response = Net::HTTP.get_response(uri)

  if response.is_a?(Net::HTTPSuccess)
    File.write('openapi.yml', response.body)
    puts "OpenAPI specification saved to openapi.yml"
  else
    puts "Failed to fetch OpenAPI specification. HTTP Status: #{response.code}"
    exit 1
  end
end
