require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HonestTest
  class Application < Rails::Application
    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]

    config.middleware.use(Rack::Config) do |env|
      env['api.tilt.root'] = Rails.root.join 'app', 'views', 'api', 'v1'
    end
  end
end
