module V1
  class SearchItem < Grape::API
    CacheItem = ActiveSupport::Cache::MemoryStore.new
    CarrefourCrawler = Crawler::Carrefour::Base
    RtCrawler = Crawler::RtMart::Base

    resource :search do
      desc "Search"
      params do
        requires :key_word
      end

      post '/', jbuilder: 'search/result' do
        @key_word = params[:key_word]

        @carrefour_results = CarrefourCrawler.new(@key_word).call.to_json
        @rt_results = RtCrawler.new(@key_word).call.to_json
      end
    end
  end
end
