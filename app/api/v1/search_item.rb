module V1
  class SearchItem < Grape::API
    CacheItem = ActiveSupport::Cache::MemoryStore.new

    resource :search do
      desc "Search"
      params do
        requires :key_word, allow_blank: false
        optional :filter_type, allow_blank: false
      end

      get '/', jbuilder: 'search/result' do
        @key_word = params[:key_word]
        price_filter = params[:filter_type]

        @carrefour_results = carrefour_crawler.new(@key_word, price_filter).call

        @rt_results = rt_mart_crawler.new(@key_word, price_filter).call
      end
    end
  end
end
