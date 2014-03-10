module RSpecRailsCaching
  class TestStore < ActiveSupport::Cache::Store

    attr_reader   :cached
    attr_reader   :expired
    attr_reader   :expiration_patterns
    attr_reader   :data
    attr_accessor :options
    attr_reader   :cached_pages
    attr_reader   :expired_pages

    attr_accessor :context

    def initialize(options = nil)
      @options = options ? options.dup : {do_read_cache: false}
      @data = {}
      @cached = []
      @expired = []
      @expiration_patterns = []
      @cached_pages = []
      @expired_pages = []
    end

    def reset
      @data.clear
      @cached.clear
      @expired.clear
      @cached_pages.clear
      @expired_pages.clear
      @expiration_patterns.clear
    end

    def read_entry(name, options = {})
      options[:do_read_cache] ? @data[name] : nil
    end

    def write_entry(name, value, options = {})
      @data[name] = value if options[:do_read_cache]
      @cached << name
    end

    def delete_entry(name, options = {})
      @expired << name
    end

    def delete_matched(matcher, options = {})
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
