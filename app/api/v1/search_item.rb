module V1
  class SearchItem < Grape::API
    CacheItem = ActiveSupport::Cache::MemoryStore.new

    resource :search do
      desc "Search"
      params do
        requires :key_word, allow_blank: false, type: String
        optional :sort_type, allow_blank: false, values: ['asc', 'desc'], default: 'asc'
				optional :limit, type: Integer
      end

      get '/', jbuilder: 'search/result' do
        @key_word = params[:key_word]
        sort_type = params[:sort_type]
				limit = params[:limit]

        @carrefour_results = carrefour_crawler.new(@key_word, sort_type, limit).call

        @rt_results = rt_mart_crawler.new(@key_word, sort_type, limit).call
      end
    end
  end
end
