module Crawler
  module RtMart
    SITE_URL = "http://www.rt-mart.com.tw/direct/".freeze

    class Base < BaseCrawler
      attr_reader :key_word

      def initialize(key_word)
        poltergeist_driver
        @key_word = key_word
      end

      def crawl
        visit SITE_URL
        wait_for_js 5
        search_item
        wait_for_js 5
        fetch_items
      end

      private

      def search_item
        within('.search') do
          find('#prod_keyword').set(key_word)
          find('#btn_submit').click
        end
      end

      def fetch_items(page = 1, page_num = fetch_page_arr, items = [])
        unless page == 1
          paginate_elements[page - 1].click
          wait_for_js 5
        end

        within('.FOR_MAIN') do
          all('.indexProList').each do |item|
            items << to_hash_format(item)
          end
        end

        return items if page_num.empty?
        fetch_items(page_num.shift(1).first,
                    page_num,
                    items
                   )
      end

      def fetch_page_arr
        page_num = []
        page_size = paginate_elements.size / 2

        (2..page_size).to_a
      end

      def paginate_elements
        within('.FOR_MAIN') do
          page_obj = all('.list_num')
        end
      end

      def to_hash_format(item)
        {
          item_name: item.find('.for_proname').text,
          item_price: item.find('.for_pricebox').text,
          img_src: item.find('.for_imgbox img')['src']
        }
      end
    end
  end
end
