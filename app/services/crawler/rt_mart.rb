module Crawler
	class RtMart < BaseCrawler
		SITE_URL = "http://www.rt-mart.com.tw/direct/".freeze

		attr_reader :agent, :key_word, :item_count

		def initialize(key_word)
			@agent = Mechanize.new
			@key_word = key_word
			@item_count = fetch_contents.search('div.left_title span').last.text
		end

		def call
			crawl
		end

		def crawl
			to_hash_format(fetch_contents.search('.indexProList'))
		end

		private

		def fetch_contents
			agent.get(SITE_URL, payload)
		end

		def payload
			{
				action: 'product_search',
				prod_keyword: key_word,
				p_data_num: item_count
			}
		end

		def to_hash_format(items)
			results = []

			items.each do |item|
				results << {
					item_name: item.search('.for_proname').text,
					item_price: price_to_int(item.search('.for_pricebox div').text),
					img_src: item.search('img').first.attributes['src'].value
				}
			end

			results
		end

		def price_to_int(value)
			value.gsub('$', '').to_i
		end
	end
end
