require 'rspec/rails'

require_relative 'rspec-rails-caching/version'
require_relative 'rspec-rails-caching/matchers'
require_relative 'rspec-rails-caching/test_store'
require_relative 'rspec-rails-caching/extensions/action_controller'

module RSpecRailsCaching

  RSpec.configure do |config|
    if ActionController::Base.perform_caching
      silence_warnings do
        Object.const_set :RAILS_CACHE, TestStore.new(do_read_cache: true)
      end
      ActionController::Base.cache_store = RAILS_CACHE

      if defined?(ActionController::Caching::Pages::PageCache)
        ActionController::Caching::Pages::PageCache.class_eval do
          prepend Extensions::ActionController::Caching::Pages::PageCache
        end
      else
        ActionController::Base.class_eval do
          extend Extensions::ActionController::ClassMethods
        end
      end

      RSpec::Rails::ControllerExampleGroup.class_eval do
        include Matchers
      end

      config.before :each do |example|
        RAILS_CACHE.reset
      end

      config.after :each do |example|
        RAILS_CACHE.reset
      end
    end
  end

end
