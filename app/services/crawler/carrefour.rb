module Crawler
	class Carrefour < BaseCrawler
		SITE_URL = "https://online.carrefour.com.tw/CarrefourECProduct/GetSearchJson".freeze

		attr_reader :key_word, :item_count

		def initialize(key_word)
			@key_word = url_encode(key_word)
			@item_count = fetch_item['Count']
		end

		def call
			crawl
		end

		def crawl
			to_hash_format(fetch_item['ProductListModel'])
		end

		private

		def fetch_item
			json_result(RestClient.post(SITE_URL, { key: key_word, PageSize: item_count }))['content']
		end

		def crawl_complete?(item_count)
			DEFAULT_ITEM_SIZE == item_count
		end

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
