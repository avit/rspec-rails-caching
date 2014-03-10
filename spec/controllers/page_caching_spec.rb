require_relative '../spec_helper'
require_relative '../resources/controllers/page_cache_spec_controller'

describe PageCacheSpecController, :type => :controller do
  describe "response.should cache_page" do

    it "matches an action for a cached page" do
      expect {
        expect { get "action_with_page_caching" }
                .to cache_page '/action_with_page_caching'
      }.to_not raise_error
    end

    it "does not match an action for an uncached page" do
      expect {
        expect { get "action_without_page_caching" }
                .to cache_page '/action_without_page_caching'
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

  end

  describe "response.should expire_page" do

    it "matches an action for an expired page" do
      expect {
        get "action_with_page_caching"
        expect { get "action_with_page_expiry" }
                .to expire_page '/action_with_page_caching'
      }.to_not raise_error
    end

    it "does not match an action without expiry" do
      expect {
        expect { get "action_with_page_caching" }
                .to expire_page '/action_with_page_caching'
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

  end

end
