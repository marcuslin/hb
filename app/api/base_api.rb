class BaseApi < Grape::API
  prefix 'api'
  format :json
  formatter :json, Grape::Formatter::Jbuilder
  mount V1::Base
end
