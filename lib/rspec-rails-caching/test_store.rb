module RSpecRailsCaching
  class TestStore < ActiveSupport::Cache::Store

    attr_reader   :cached
    attr_reader   :expired
    attr_reader   :expiration_patterns
    attr_reader   :data
    attr_accessor :read_cache
    attr_reader   :cached_pages
    attr_reader   :expired_pages

    attr_accessor :context

    def initialize(do_read_cache = false)
      @data = {}
      @cached = []
      @expired = []
      @expiration_patterns = []
      @read_cache = do_read_cache
      @cached_pages = []
      @expired_pages = []
    end

    def reset
      @data.clear
      @cached.clear
      @expired.clear
      @expiration_patterns.clear
    end

    def read_entry(name, options = nil)
      read_cache ? @data[name] : nil
    end

    def write_entry(name, value, options = nil)
      @data[name] = value if read_cache
      @cached << name
    end

    def delete_entry(name, options = nil)
      @expired << name
    end

    def delete_matched(matcher, options = nil)
      @expiration_patterns << matcher
    end

    def cached?(name)
      @cached.include?(name)
    end

    def expired?(name)
      @expired.include?(name) || @expiration_patterns.detect { |matcher| name =~ matcher }
    end

    def page_cached?(options = {})
      @cached_pages.include?(test_cache_url(options))
    end

    def page_expired?(options = {})
      @expired_pages.include?(test_cache_url(options))
    end

    private
    def test_cache_url(options)
      return options if options.is_a?(String)
      url_for(options.merge(:only_path => true, :skip_relative_url_root => true))
    end
  end
end
