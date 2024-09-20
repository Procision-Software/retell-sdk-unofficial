require 'spec_helper'

RSpec.describe Retell::SDK::Unofficial::Concurrency do
  let(:concurrency) {
    @client.concurrency.retrieve
  }

  describe '#retrieve' do
    it 'retrieves the concurrency' do
      expect(@client.concurrency).to receive(:retrieve).and_return(concurrency)

      retrieved_concurrency = concurrency.retrieve
      expect(retrieved_concurrency).to be_a(Retell::SDK::Unofficial::Concurrency)
    end
  end
end
