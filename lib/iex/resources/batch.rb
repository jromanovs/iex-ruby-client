require_relative 'batch/base'

module IEX
  module Resources
    module Batch
      def self.parseItem(response)
        Batch::Base.new response
        # Hash[
        #   response.map do |k, v|
        #     case k
        #     when 'quote'
        #       [k, Quote.new(v)]
        #     when 'news'
        #       [k, News.new(v)]
        #     when 'chart'
        #       [k, Chart.new(v)]
        #     end
        #   end
        # ]
      end

      def self.parseArray(response)
        Hash[response.map do |k, v|
          [k, parseItem(v)]
        end]
      end

      def self.get(symbol)
        response = IEX::Api::Batch.get(symbol)
        if symbol.is_a?(Array)
          parseArray(response)
        else
          parseItem(response)
        end
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
