require 'uri'
require 'capybara/rails'
require 'capybara/dsl'
require 'capybara/poltergeist'

module Crawler
  class BaseCrawler
    include Capybara::DSL
    include ERB::Util

    def initialize
    end

    def poltergeist_driver(image_enabled = false)
      phantomjs_options = []
      if image_enabled
        phantomjs_options = [
          '--proxy-type=none',
          '--ignore-ssl-errors=yes',
          '--ssl-protocol=any',
          '--web-security=false'
        ]
      else
        phantomjs_options = [
          '--proxy-type=none',
          '--load-images=no',
          '--ignore-ssl-errors=yes',
          '--ssl-protocol=any',
          '--web-security=false'
        ]
      end
      driver_options = {
        timeout: 30,
        window_size: [1280, 1440],
        js_errors: false,
        phantomjs_options: phantomjs_options
      }
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, driver_options)
      end
      Capybara.javascript_driver = :poltergeist
      Capybara.current_driver = Capybara.javascript_driver
      Capybara::Session.new(:poltergeist)
      page.driver.headers =
        {"user-agent": 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36.',
         "accept-language": 'zh-tw'
      }
    end
  end
end


