require 'spec_helper'

RSpec.describe Retell::SDK::Unofficial::API::RetellLLM do
  let(:client) { @client }

  describe '#create' do
    it 'creates a Retell LLM with minimal parameters' do
      llm = client.retell_llm.create(
        model: 'gpt-4o'
      )
      expect(llm).to be_a(Retell::SDK::Unofficial::RetellLLM)
    end

    it 'creates a Retell LLM with all parameters' do
      llm = client.retell_llm.create(
        model: 'gpt-4o',
        model_temperature: 0.5,
        begin_message: 'Hello, how can I assist you?',
        general_prompt: 'You are a helpful assistant.',
        general_tools: [
          { type: 'end_call', name: 'end_call_tool' },
          { type: 'transfer_call', name: 'transfer_call_tool', number: '+12125551212' }
        ],
        inbound_dynamic_variables_webhook_url: 'https://example.com/webhook',
        starting_state: 'initial',
        states: [
          { name: 'initial', state_prompt: 'This is the initial state.' }
        ]
      )
      expect(llm).to be_a(Retell::SDK::Unofficial::RetellLLM)
    end

    it 'raises an error for invalid model' do
      expect {
        client.retell_llm.create(model: 'invalid-model')
      }.to raise_error(ArgumentError, /Invalid model/)
    end
  end

  describe '#retrieve' do
    it 'retrieves a Retell LLM' do
      llm = client.retell_llm.retrieve('16b980523634a6dc504898cda492e939')
      expect(llm).to be_a(Retell::SDK::Unofficial::RetellLLM)
    end
  end

  describe '#update' do
    it 'updates a Retell LLM' do
      llm = client.retell_llm.update(
        '16b980523634a6dc504898cda492e939',
        general_prompt: 'You are a friendly AI assistant.'
      )
      expect(llm).to be_a(Retell::SDK::Unofficial::RetellLLM)
    end

    it 'raises an error for invalid update parameters' do
      expect {
        client.retell_llm.update(
          retell_llm_id: '16b980523634a6dc504898cda492e939',
          invalid_param: 'value'
        )
      }.to raise_error(ArgumentError)
    end
  end

  describe '#list' do
    it 'lists Retell LLMs' do
      llms = client.retell_llm.list
      expect(llms).to be_a(Retell::SDK::Unofficial::RetellLLMList)
      expect(llms.first).to be_a(Retell::SDK::Unofficial::RetellLLM)
    end
  end

  describe '#delete' do
    it 'deletes a Retell LLM' do
      result = client.retell_llm.delete('oBeDLoLOeuAbiuaMFXRtDOLriTJ5tSxD')
      expect(result).to be_nil
    end
  end

  describe 'private methods' do
    # let(:retell_llm) { Retell::RetellLLM.new(client: client) }

    describe '#validate_model' do
      it 'validates correct models' do
        valid_models = ['gpt-4o', 'gpt-4o-mini', 'claude-3.5-sonnet', 'claude-3-haiku']
        valid_models.each do |model|
          expect { client.retell_llm.send(:validate_model, model) }.not_to raise_error
        end
      end

      it 'raises an error for invalid models' do
        expect {
          client.retell_llm.send(:validate_model, 'invalid-model')
        }.to raise_error(ArgumentError, /Invalid model/)
      end
    end

    describe '#validate_general_tools' do
      it 'validates correct general tools' do
        valid_tools = [
          { type: 'end_call', name: 'End Call' },
          { type: 'transfer_call', name: 'Transfer Call', number: '+1234567890' }
        ]
        expect {
          client.retell_llm.send(:validate_general_tools, valid_tools)
        }.not_to raise_error
      end

      it 'raises an error for invalid general tools' do
        invalid_tools = [{ type: 'invalid_tool', name: 'Invalid Tool' }]
        expect {
          client.retell_llm.send(:validate_general_tools, invalid_tools)
        }.to raise_error(ArgumentError)
      end
    end

    describe '#validate_states' do
      it 'validates correct states' do
        valid_states = [
          { name: 'initial', state_prompt: 'This is the initial state.' }
        ]
        expect {
          client.retell_llm.send(:validate_states, valid_states)
        }.not_to raise_error
      end

      it 'raises an error for invalid states' do
        invalid_states = [
          { invalid_key: 'value' }
        ]
        expect {
          client.retell_llm.send(:validate_states, invalid_states)
        }.to raise_error(ArgumentError)
      end
    end
  end
end
