require 'spec_helper'

RSpec.describe Retell::SDK::Unofficial::API::Concurrency do
  let(:client) { @client }

  describe '#retrieve' do
    it 'retrieves concurrency information' do
      concurrency = client.concurrency.retrieve
      expect(concurrency).to be_a(Retell::SDK::Unofficial::Concurrency)
      expect(concurrency.current_concurrency).to be_a(Integer)
      expect(concurrency.concurrency_limit).to be_a(Integer)
    end
  end
end
