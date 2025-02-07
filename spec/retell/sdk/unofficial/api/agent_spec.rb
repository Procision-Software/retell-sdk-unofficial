require 'spec_helper'

RSpec.describe Retell::SDK::Unofficial::API::Agent do
  let(:client) { @client }

  describe '#create' do
    it 'creates an agent with minimal parameters' do
      agent = client.agent.create(
        response_engine: { type: "custom-llm", llm_websocket_url: 'wss://your-websocket-endpoint' },
        voice_id: '11labs-Adrian'
      )
      expect(agent).to be_a(Retell::SDK::Unofficial::Agent)
    end

    it 'creates an agent with all parameters' do
      agent = client.agent.create(
        response_engine: { type: "retell-llm", llm_id: 'retell-llm-id-123' },
        voice_id: '11labs-Adrian',
        agent_name: 'Jarvis',
        ambient_sound: 'coffee-shop',
        ambient_sound_volume: 1,
        backchannel_frequency: 0.9,
        backchannel_words: ['yeah', 'uh-huh'],
        boosted_keywords: ['retell', 'kroger'],
        enable_backchannel: true,
        enable_voicemail_detection: true,
        end_call_after_silence_ms: 600000,
        fallback_voice_ids: ['openai-Alloy', 'deepgram-Angus'],
        interruption_sensitivity: 1,
        language: 'en-US',
        max_call_duration_ms: 3600000,
        normalize_for_speech: true,
        opt_out_sensitive_data_storage: true,
        post_call_analysis_data: [
          {
            description: 'The name of the customer.',
            name: 'customer_name',
            type: 'string',
            examples: ['John Doe', 'Jane Smith']
          }
        ],
        pronunciation_dictionary: [
          {
            alphabet: 'ipa',
            phoneme: 'ˈæktʃuəli',
            word: 'actually'
          }
        ],
        reminder_max_count: 2,
        reminder_trigger_ms: 10000,
        responsiveness: 1,
        voice_model: 'eleven_turbo_v2',
        voice_speed: 1,
        voice_temperature: 1,
        voicemail_detection_timeout_ms: 30000,
        voicemail_message: 'Hi, please give us a callback.',
        volume: 1,
        webhook_url: 'https://webhook-url-here'
      )
      expect(agent).to be_a(Retell::SDK::Unofficial::Agent)
    end

    it 'creates an agent with extra options' do
      agent = client.agent.create(
        response_engine: { type: "conversation-flow", conversation_flow_id: 'flow123' },
        voice_id: '11labs-Adrian',
        extra_headers: { 'X-Custom-Header' => 'CustomValue' },
        extra_query: { 'custom_query' => 'value' },
        extra_body: { 'extra_body_param' => 'value' },
        timeout: 30
      )
      expect(agent).to be_a(Retell::SDK::Unofficial::Agent)
    end
  end

  describe '#retrieve' do
    it 'retrieves an agent' do
      agent = client.agent.retrieve('16b980523634a6dc504898cda492e939')
      expect(agent).to be_a(Retell::SDK::Unofficial::Agent)
    end
  end

  describe '#update' do
    it 'updates an agent' do
      agent = client.agent.update(
        '16b980523634a6dc504898cda492e939',
        agent_name: 'Updated Jarvis'
      )
      expect(agent).to be_a(Retell::SDK::Unofficial::Agent)
    end
  end

  describe '#list' do
    it 'lists agents' do
      agents = client.agent.list
      expect(agents).to be_a(Retell::SDK::Unofficial::AgentList)
      expect(agents.first).to be_a(Retell::SDK::Unofficial::Agent)
    end
  end

  describe '#delete' do
    it 'deletes an agent' do
      result = client.agent.delete('oBeDLoLOeuAbiuaMFXRtDOLriTJ5tSxD')
      expect(result).to be_nil
    end
  end

  describe 'float conversion' do
    it 'converts specific integer fields to floats for agents' do
      agent = client.agent.create(
        response_engine: { type: "custom-llm", llm_websocket_url: 'wss://your-websocket-endpoint' },
        voice_id: '11labs-Adrian',
        agent_name: 'Float Test Agent',
        ambient_sound_volume: 1,
        backchannel_frequency: 1,
        interruption_sensitivity: 1,
        responsiveness: 1,
        voice_speed: 1,
        voice_temperature: 1,
        end_call_after_silence_ms: 600000  # This should remain an integer
      )
      expect(agent.ambient_sound_volume).to be_a(Float)
      expect(agent.backchannel_frequency).to be_a(Float)
      expect(agent.interruption_sensitivity).to be_a(Float)
      expect(agent.responsiveness).to be_a(Float)
      expect(agent.voice_speed).to be_a(Float)
      expect(agent.voice_temperature).to be_a(Float)
      expect(agent.end_call_after_silence_ms).to be_a(Integer)
    end
  end
end
