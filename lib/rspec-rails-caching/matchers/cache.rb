require 'rspec-rails-caching/matchers/base'

module RSpecRailsCaching::Matchers

  caching_matcher :cache do
    def cache_results
      cache_store.cached
    end
  end
  alias_method :cache_fragment, :cache
  alias_method :cache_action,   :cache

end
