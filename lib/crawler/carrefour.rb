module Crawler
  module Carrefour
    SITE_URL = Figaro.env.carrefour_url

    class Base < BaseCrawler
      attr_reader :key_word

      def initialize(key_word)
        poltergeist_driver
        @key_word = url_encode(key_word)
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
        wait_for_js 5

        within(".items-block") do
          items = all('.item-product')
        end

        current_count += items.size

        return items if previous_count == current_count

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

        result
      end
    end
  end
end
