class BaseApi < Grape::API
  helpers do
    def carrefour_crawler
      Crawler::Carrefour
    end

    def rt_mart_crawler
      Crawler::RtMart
    end
  end

  prefix 'api'
  format :json
  formatter :json, Grape::Formatter::Jbuilder
  mount V1::Base
end
