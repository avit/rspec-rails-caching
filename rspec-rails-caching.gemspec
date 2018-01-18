# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rspec-rails-caching/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "rspec-rails-caching"
  gem.version     = RSpecRailsCaching::VERSION
  gem.authors     = ["Andrew Vit"]
  gem.email       = ["andrew@avit.ca"]
  gem.homepage    = "https://github.com/avit/rspec-rails-caching"
  gem.summary     = %q{RSpec Rails Caching}
  gem.description = %q{RSpec helper for testing page and action caching in Rails}

  gem.required_ruby_version = Gem::Requirement.new(">= 2.0.0")

  gem.add_dependency "rails", ">=3.0.0"
  gem.add_dependency "rspec", ">=2.8.0"
  gem.add_dependency "rspec-rails", ">=2.10.0"

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]
end
