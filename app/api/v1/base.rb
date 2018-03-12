module V1
  class Base < Grape::API
    version 'v1'
    mount V1::SearchItem
  end
end
