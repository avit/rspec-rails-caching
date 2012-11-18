require 'rspec-rails-caching/matchers/base'

module RSpecRailsCaching::Matchers

  caching_matcher :cache_page do
    def cache_or_expire
      "cache page"
    end

    def cache_results
      cache_store.cached_pages
    end
  end

end
