module RSpecRailsCaching::Matchers
  extend RSpec::Matchers::DSL

  matcher :cache_page do |*expected|
    match do |actual|
      actual = actual.call if actual.respond_to?(:call)
      unless actual.is_a? ActionController::TestResponse
        raise ArgumentError("cache_page matcher expects a callable Proc or a TestResponse")
      end

      Array(expected).all? { |e| cache_store.page_cached?(e) }
    end

    failure_message_for_should do |actual|
      "expected #{controller.class} to cache: #{expected.inspect} but got #{cache_results.inspect}"
    end

    failure_message_for_should_not do |actual|
      "expected #{controller.class} not to cache: #{expected.inspect} but got #{cache_results.inspect}"
    end

    description do
      "cache page #{expected.inspect}"
    end

    def controller
      matcher_execution_context.controller
    end

    def cache_store
      controller.cache_store
    end

    def cache_results
      cache_store.cached_pages
    end
  end
end
