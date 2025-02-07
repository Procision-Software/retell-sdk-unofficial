require 'spec_helper'

RSpec.describe Retell::SDK::Unofficial::Agent do
  let(:agent) do
    @client.agent.create(
      response_engine: { type: "custom-llm", llm_websocket_url: "wss://example.com" },
      voice_id: 'test_voice_id',
      agent_name: 'Test Agent'
    )
  end

  describe '#retrieve' do
    it 'retrieves the agent' do
      expect(@client.agent).to receive(:retrieve).with(agent).and_return(agent)

      retrieved_agent = agent.retrieve
      expect(retrieved_agent).to be_a(Retell::SDK::Unofficial::Agent)
    end
  end

  describe '#update' do
    it 'updates the agent' do
      expect(@client.agent).to receive(:update).with(agent, agent_name: 'Updated Agent').and_return(agent)

      updated_agent = agent.update(agent_name: 'Updated Agent')
      expect(updated_agent).to be_a(Retell::SDK::Unofficial::Agent)
    end
  end

  describe '#delete' do
    it 'deletes the agent' do
      expect(@client.agent).to receive(:delete).with(agent).and_return(nil)

      result = agent.delete
      expect(result).to be_nil
    end
  end
end
