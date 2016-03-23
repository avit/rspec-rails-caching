require 'rspec-rails-caching/matchers/base'

module RSpecRailsCaching::Matchers

  caching_matcher :expire do
    define_method :cache_or_expire do
      "expire"
    end

    define_method :cache_results do
      cache_store.expired
    end
  end

end
