# frozen_string_literal: true

require_relative "lib/retell/sdk/unofficial/version"

Gem::Specification.new do |spec|
  spec.name          = "retell-sdk-unofficial"
  spec.version       = Retell::SDK::Unofficial::VERSION
  spec.authors       = ["Greg Yardley"]
  spec.email         = ["greg@yardley.ca"]

  spec.summary       = "An unofficial Ruby client for the RetellAI API"
  spec.description   = "This unofficial Ruby library provides convenient access to the RetellAI REST API."
  spec.homepage      = "https://github.com/gyardley/retell-sdk-unofficial"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/gyardley/retell-sdk-unofficial"
  spec.metadata["changelog_uri"] = "https://github.com/gyardley/retell-sdk-unofficial/CHANGELOG.md"

  spec.files         = Dir["lib/**/*.rb"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "httparty"

  # Development dependencies
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rbs", "~> 3.5"
  spec.add_development_dependency "steep", "~> 1.7"
end
