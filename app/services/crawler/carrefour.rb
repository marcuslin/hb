module Crawler
	class Carrefour < BaseCrawler
		SITE_URL = "https://online.carrefour.com.tw/CarrefourECProduct/GetSearchJson".freeze

		def call
      to_hash_format(fetch_contents['ProductListModel'])
		end

    def fetch_contents
      json_result(RestClient.post(SITE_URL, { key: key_word, PageSize: item_count }))['content']
    end

    def fetch_count
      fetch_contents['Count']
    end

		private

		def json_result(results)
			JSON.parse(results)
		end

		def to_hash_format(items)
			results = []

			items.each do |item|
				results << {
					item_name: "#{item['Name']} #{item['ItemQtyPerPackFormat']}",
					item_price: price_for(item).to_i,
					img_src: item['PictureUrl']
				}
			end

			results
		end

		def price_for(item)
			item['SpecialPrice'].blank? ? item['Price'] : item['SpecialPrice']
		end
	end
end
