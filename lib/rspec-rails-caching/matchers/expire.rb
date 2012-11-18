require 'rspec-rails-caching/matchers/base'

module RSpecRailsCaching::Matchers

  caching_matcher :expire do
    def cache_results
      cache_store.expired
    end
  end

end
