module RSpecRailsCaching::Extensions
  module ActionController

    module ClassMethods
      def cache_page(content, path, extension = nil, *)
        instrument_page_cache :write_page, path do
          cache_store.cached_pages << path
        end
      end

      def expire_page(path)
        instrument_page_cache :expire_page, path do
          cache_store.cached_pages.delete path
          cache_store.expired_pages << path
        end
      end
    end

  end
end
