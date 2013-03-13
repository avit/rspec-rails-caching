require 'rspec-rails-caching/version'
require 'rspec-rails-caching/matchers'
require 'rspec-rails-caching/test_store'
require 'rspec-rails-caching/extensions/action_controller'

module RSpecRailsCaching

  RSpec.configure do |config|
    if ActionController::Base.perform_caching
      silence_warnings do
        Object.const_set :RAILS_CACHE, TestStore.new(true)
      end
      ActionController::Base.cache_store = RAILS_CACHE
      ActionController::Base.class_eval do
        extend Extensions::ActionController::ClassMethods
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
