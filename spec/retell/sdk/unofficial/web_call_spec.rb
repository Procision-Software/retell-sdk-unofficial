require 'spec_helper'

RSpec.describe Retell::SDK::Unofficial::WebCall do
  let(:web_call) {
    @client.call.create_web_call(
      agent_id: 'test_agent_id',
    )
   }

  describe '#retrieve' do
    it 'retrieves the web call' do
      expect(@client.call).to receive(:retrieve).with(web_call).and_return(web_call)

      retrieved_web_call = web_call.retrieve
      expect(retrieved_web_call).to be_a(Retell::SDK::Unofficial::WebCall)
    end
  end
end
