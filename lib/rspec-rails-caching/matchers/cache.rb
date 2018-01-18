require 'rspec-rails-caching/matchers/base'

module RSpecRailsCaching::Matchers

  caching_matcher :cache do
    define_method :cache_or_expire do
      "cache"
    end

    define_method :cache_results do
      cache_store.cached
    end
  end
  alias_method :cache_fragment, :cache
  alias_method :cache_action,   :cache

end
