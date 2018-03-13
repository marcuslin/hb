class BaseApi < Grape::API
  helpers do
    def carrefour_crawler
      Crawler::Carrefour::Base
    end

    def rt_mart_crawler
      Crawler::RtMart::Base
    end
  end

  prefix 'api'
  format :json
  formatter :json, Grape::Formatter::Jbuilder
  mount V1::Base
end
