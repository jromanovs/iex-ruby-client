require 'spec_helper'

describe IEX::Resources::Batch do
  context 'known symbol', vcr: { cassette_name: 'batch/msft' } do
    subject do
      IEX::Resources::Batch.get('MSFT')
    end
    it 'retrieves a quote' do
      expect(subject.quote.symbol).to eq 'MSFT'
      expect(subject.quote.primary_exchange).to eq 'Nasdaq Global Select'
      expect(subject.quote.company_name).to eq 'Microsoft Corporation'
      expect(subject.quote.market_cap).to eq 778_384_739_029
    end
  end
  context 'list of symbols', vcr: { cassette_name: 'batch/listofsymbols' } do
    subject do
      IEX::Resources::Batch.get(%w[MSFT AAPL IBM])
    end
    it 'retrieves a quote' do
      expect(subject.size).to eq 3
      expect(subject['IBM'].quote.symbol).to eq 'IBM'
      expect(subject['AAPL'].quote.symbol).to eq 'AAPL'
      expect(subject['MSFT'].quote.symbol).to eq 'MSFT'
      expect(subject['MSFT'].quote.primary_exchange).to eq 'Nasdaq Global Select'
      expect(subject['MSFT'].quote.company_name).to eq 'Microsoft Corporation'
      expect(subject['MSFT'].quote.market_cap).to eq 780_497_618_342
    end
  end
end
