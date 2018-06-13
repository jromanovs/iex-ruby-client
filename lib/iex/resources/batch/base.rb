module IEX
  module Resources
    module Batch
      class Base < Resource
        property 'quote', transform_with: ->(v) { Quote.new(v) }
        property 'news'
        property 'chart'
        property 'company'
      end
    end
  end
end
