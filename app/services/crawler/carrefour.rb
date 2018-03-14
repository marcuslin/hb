module Crawler
  module Carrefour
    SITE_URL = "https://online.carrefour.com.tw/".freeze

    class Base < BaseCrawler
      attr_reader :key_word

      def initialize(key_word)
        poltergeist_driver
        @key_word = url_encode(key_word)
      end

      def call
        Rails.cache.fetch("#{key_word}_carrefour") do
          crawl
        end
      end

      def crawl
        visit "#{SITE_URL}search?key=#{key_word}"
        wait_for_js 10

        to_hash_format(fetch_items)
      end

      private

      def fetch_items(previous_count = 0, execute_num = 1)
        items = ''
        current_count = 0
        execute_script('window.scroll(0,999999);')
        wait_for_js 1

        within(".items-block") do
          items = all('.item-product')
        end

        current_count += items.size

        return items if crawl_complete?(previous_count, current_count)

        previous_count = current_count
        execute_num += 1

        fetch_items(previous_count, execute_num)
      end

      def to_hash_format(items)
        result = []

        items.each do |item|
          result << { item_name: item.find('.item-name').text,
                      item_price: item.find('.discount-price').text,
                      img_src: item.find('.label-wrap .center-block')['src']
          }					
        end

        Rails.logger.tagged { Rails.logger.info("finish fetching") }
        result
      end

      def crawl_complete?(previous_count, current_count)
        previous_count == current_count
      end
    end
  end
end
