module RSpecRailsCaching
  module Matchers
    extend RSpec::Matchers::DSL

    def self.caching_matcher name, &block
      matcher name do
        match do |actual|
          actual = actual.call if actual.respond_to?(:call)
          Array(expected).all? { |e| cache_results.include?(e) }
        end

        description do
          "#{cache_or_expire} #{expected.inspect}"
        end

        failure_message_when_negated do |actual|
          "Expected #{controller.class} not to #{cache_or_expire} #{expected.inspect} but got #{cache_results.inspect}"
        end

        failure_message do |actual|
          "Expected #{controller.class} to #{cache_or_expire} #{expected.inspect} but got #{cache_results.inspect}"
        end

        def supports_block_expectations?
          true
        end

        def cache_store
          controller.cache_store
        end

        def cache_results
          fail NoMethodError, "Abstract method 'cache_results' to be defined in matcher"
        end

        def cache_or_expire
          fail NoMethodError, "Abstract method 'cache_or_expire' to be defined in matcher"
        end

        module_eval &block

      end
    end
  end
end
