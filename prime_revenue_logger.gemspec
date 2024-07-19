# frozen_string_literal: true

require_relative 'lib/prime_revenue_logger/version'

Gem::Specification.new do |spec|
  spec.name          = "prime_revenue_logger"
  spec.version       = PrimeRevenueLogger::VERSION
  spec.authors       = ["Thomas Doyle-Engler"]
  spec.email         = ["tengler@primerevenue.com"]

  spec.summary       = "A custom JSON logger for Prime Revenue Ruby applications"
  spec.description   = "Standardizes the output for applications logging to JSON format."
  spec.homepage      = "http://example.com"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*.rb"]
  spec.require_paths = ["lib"]

  spec.add_dependency "json"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://example.com/source_code"
  spec.metadata["changelog_uri"] = "http://example.com/changelog"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.required_ruby_version = ">= 2.5"
end
