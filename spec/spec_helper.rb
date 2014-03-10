require 'rails'
require 'action_controller/railtie'
unless Rails::VERSION::MAJOR < 4
  require 'action_controller/action_caching'
  require 'action_controller/page_caching'
end
require 'rspec/rails'
require 'rspec-rails-caching'

module RSpec::Rails
  class Application < ::Rails::Application
    config.secret_key_base = 'test'
    config.action_controller.page_cache_directory =
      File.dirname(__FILE__)
  end
end

RSpec.configure do |config|
  config.before(:each) do
    @real_world = RSpec.world
    RSpec.instance_variable_set(:@world, RSpec::Core::World.new)
  end
  config.after(:each) do
    RSpec.instance_variable_set(:@world, @real_world)
  end
  config.order = :random
end
