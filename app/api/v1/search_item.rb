module V1
  class SearchItem < Grape::API
    CacheItem = ActiveSupport::Cache::MemoryStore.new

    resource :search do
      desc "Search"
      params do
        requires :key_word, allow_blank: false
        optional :sort_type, allow_blank: false, values: ['asc', 'desc'], default: 'asc'
      end

      get '/', jbuilder: 'search/result' do
        @key_word = params[:key_word]
        sort_type = params[:sort_type]

        @carrefour_results = carrefour_crawler.new(@key_word, sort_type).call

        @rt_results = rt_mart_crawler.new(@key_word, sort_type).call
      end
    end
  end
end
