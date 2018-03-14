module V1
  class SearchItem < Grape::API
    resource :search do
      desc "Search"
      params do
        requires :key_word, allow_blank: false
      end

      post '/', jbuilder: 'search/result' do
        @key_word = params[:key_word]

        @carrefour_results = carrefour_crawler.new(@key_word).crawl.to_json

        @rt_results = CacheItem.fetch("#{@key_word}_rt", expires_in: 1.hour) {
          rt_mart_crawler.new(@key_word).call.to_json
        }
      end
    end
  end
end
