require 'rspec-rails-caching/matchers/base'

module RSpecRailsCaching::Matchers

  caching_matcher :cache_page do
    define_method :cache_or_expire do
      "cache page"
    end

    define_method :cache_results do
      cache_store.cached_pages
    end
  end

end
