module IEX
  module Api
    module Batch
      def self.get(symbol, _types = [:quote])
        if symbol.is_a?(Array)
          connection('market').get do |c|
            c.params[:types] = 'quote'
            c.params[:symbols] = symbol.join(',')
          end.body
        else
          connection(symbol).get do |c|
            c.params[:types] = 'quote'
          end.body
        end
      end

      def self.connection(symbol)
        IEX::Api.default_connection "#{symbol}/batch"
      end
    end
  end
end
