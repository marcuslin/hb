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

      post '/' do
        key_word = params[:key_word]

        carrefour_result = CacheItem.fetch("#{key_word}_carrefour", expires_in: 1.hour) {
          CarrefourCrawler.new(key_word).call.to_json
        }

        rt_result = CacheItem.fetch("#{key_word}_rt", expires_in: 1.hour) {
          RtCrawler.new(key_word).call.to_json
        }

        { 
          car: carrefour_result,
          rt: rt_result
        }
      end
    end
  end
end
