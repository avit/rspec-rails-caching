require 'rspec-rails-caching/matchers/base'

module RSpecRailsCaching::Matchers

  caching_matcher :expire_page do
    define_method :cache_or_expire do
      "expire page"
    end

    define_method :cache_results do
      cache_store.expired_pages
    end
  end

end
