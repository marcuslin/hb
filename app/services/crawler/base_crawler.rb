require 'uri'
require 'mechanize'

module Crawler
  class BaseCrawler
    include ERB::Util

    attr_reader :key_word, :item_count

    def initialize(key_word)
      @key_word = key_word
      @item_count = fetch_count
    end

    def call
      raise NotImplementedError
    end

    def fetch_count
      raise NotImplementedError
    end

    def fetch_contents
      raise NotImplementedError
    end
  end
end
