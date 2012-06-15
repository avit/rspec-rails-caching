# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rspec-rails-caching/version"

Gem::Specification.new do |s|
  s.name        = "rspec-rails-caching"
  s.version     = RSpecRailsCaching::VERSION
  s.authors     = ["Andrew Vit"]
  s.email       = ["andrew@avit.ca"]
  s.homepage    = "https://github.com/avit/rspec-rails-caching"
  s.summary     = %q{RSpec Rails Caching}
  s.description = %q{RSpec helper for testing page and action caching in Rails}

  s.rubyforge_project = "rspec-rails-caching"
  s.add_dependency "rails", ">=3.0.0"
  s.add_dependency "rspec", ">=2.8.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
