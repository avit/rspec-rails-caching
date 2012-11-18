require 'rspec-rails-caching/version'
require 'rspec-rails-caching/matchers'
require 'rspec-rails-caching/test_store'
require 'rspec-rails-caching/extensions/action_controller'

module RSpecRailsCaching
  RSpec::Rails::ControllerExampleGroup.class_eval do
    include Matchers
  end

  RSpec.configure do |config|
    config.before(:all, :type => :controller, :caching => true) do |example|
      silence_warnings do
        @_orig_cache_store = RAILS_CACHE
        Object.const_set "RAILS_CACHE", TestStore.new
      end

      ActionController::Base.cache_store = RAILS_CACHE
      ActionController::Base.perform_caching = true

      # The controller needs to be reloaded to metaprogram the caches_page
      # callback with the perform_caching option turned on. There is no
      # reloading if the example controller isn't in the load paths, likely
      # because it was defined inline in the spec or an AnonymousController.
      if ctrl_class_file =
        ActiveSupport::Dependencies.search_for_file(example.class.controller_class.to_s.underscore)
        then
        # FIXME: the controller's cache_page callbacks don't get triggered
        # when the test suite runs an outer example group (without caching:
        # true), but individual examples will pass.
        ActiveSupport::Dependencies.load(ctrl_class_file)
      end

      example.class.controller_class.class_eval do
        self.perform_caching = true
        extend Extensions::ActionController::ClassMethods
      end
    end

    config.after(:all, :type => :controller, :caching => true) do |example|
      silence_warnings do
        Object.const_set "RAILS_CACHE", @_orig_cache_store
      end
      ActionController::Base.cache_store = RAILS_CACHE
      ActionController::Base.perform_caching = false
    end
  end

end
