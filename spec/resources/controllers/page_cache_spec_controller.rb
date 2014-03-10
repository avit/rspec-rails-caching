class PageCacheSpecController < ActionController::Base
  include Rails.application.routes.url_helpers

  caches_page :action_with_page_caching

  def action_without_page_caching
    render :text => ""
  end

  def action_with_page_caching
    render :text => ""
  end

  def action_with_page_expiry
    expire_page :action => 'action_with_page_caching'
    render :text => ""
  end
end

RSpec::Rails::Application.routes.draw do
  get "action_without_page_caching",
      :controller => "page_cache_spec",
      :action     => "action_without_page_caching"

  get "action_with_page_caching",
      :controller => "page_cache_spec",
      :action     => "action_with_page_caching"

  get "action_with_page_expiry",
      :controller => "page_cache_spec",
      :action     => "action_with_page_expiry"
end
