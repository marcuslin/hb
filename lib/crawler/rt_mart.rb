module Crawler
  module RtMart
    SITE_URL = Figaro.env.rt_mart_url

    class Base < BaseCrawler
      attr_reader :key_word

      def initialize(key_word)
        poltergeist_driver
        @key_word = key_word
      end

      def crawl
        visit SITE_URL
        sleep 5
        search_item
        sleep 5
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
          sleep 5
        end

        within('.FOR_MAIN') do
          all('.indexProList').each do |item|
            items << to_hash_format(item)
          end

          puts items
        end

        puts "current_page: #{page}, pages_left: #{page_num}"

        return items if page_num.empty?
        fetch_items(page_num.shift(1).first,
                    page_num,
                    items
                   )
      end;0

      def fetch_page_arr
        page_num = []

        page_size = paginate_elements.size / 2
        page_num = (2..page_size).to_a

        return page_num
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
