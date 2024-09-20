require 'spec_helper'

RSpec.describe Retell::SDK::Unofficial::API::Call do
  let(:client) { @client }

  describe '#create_web_call' do
    it 'creates a web call with minimal parameters' do
      call = client.call.create_web_call(
        agent_id: 'oBeDLoLOeuAbiuaMFXRtDOLriTJ5tSxD'
      )
      expect(call).to be_a(Retell::SDK::Unofficial::WebCall)
    end

    it 'creates a web call with all parameters' do
      call = client.call.create_web_call(
        agent_id: 'oBeDLoLOeuAbiuaMFXRtDOLriTJ5tSxD',
        metadata: { customer_id: '12345' },
        retell_llm_dynamic_variables: { customer_name: 'John Doe' }
      )
      expect(call).to be_a(Retell::SDK::Unofficial::WebCall)
    end
  end

  describe '#create_phone_call' do
    it 'creates a phone call with minimal parameters' do
      call = client.call.create_phone_call(
        from_number: '+14157774444',
        to_number: '+12137774445'
      )
      expect(call).to be_a(Retell::SDK::Unofficial::PhoneCall)
    end

    it 'creates a phone call with all parameters' do
      call = client.call.create_phone_call(
        from_number: '+14157774444',
        to_number: '+12137774445',
        override_agent_id: 'oBeDLoLOeuAbiuaMFXRtDOLriTJ5tSxD',
        metadata: { customer_id: '12345' },
        retell_llm_dynamic_variables: { customer_name: 'John Doe' }
      )
      expect(call).to be_a(Retell::SDK::Unofficial::PhoneCall)
    end
  end

  describe '#register' do
    it 'registers a phone call with minimal parameters' do
      call = client.call.register(
        agent_id: 'oBeDLoLOeuAbiuaMFXRtDOLriTJ5tSxD'
      )
      expect(call).to be_a(Retell::SDK::Unofficial::PhoneCall)
    end

    it 'registers a phone call with all parameters' do
      call = client.call.register(
        agent_id: 'oBeDLoLOeuAbiuaMFXRtDOLriTJ5tSxD',
        direction: 'inbound',
        from_number: '+14157774444',
        to_number: '+12137774445',
        metadata: { customer_id: '12345' },
        retell_llm_dynamic_variables: { customer_name: 'John Doe' }
      )
      expect(call).to be_a(Retell::SDK::Unofficial::PhoneCall)
    end
  end

  describe '#retrieve' do
    it 'retrieves a call' do
      call = client.call.retrieve('119c3f8e47135a29e65947eeb34cf12d')
      expect(call).to be_a(Retell::SDK::Unofficial::WebCall)
    end
  end

  describe '#list' do
    it 'lists calls with minimal parameters' do
      calls = client.call.list
      expect(calls).to be_a(Retell::SDK::Unofficial::CallList)
      expect(calls.first).to satisfy { |call| call.is_a?(Retell::SDK::Unofficial::WebCall) || call.is_a?(Retell::SDK::Unofficial::PhoneCall) }
    end

    it 'lists calls with all parameters' do
      calls = client.call.list(
        filter_criteria: {
          agent_id: ['oBeDLoLOeuAbiuaMFXRtDOLriTJ5tSxD'],
          before_start_timestamp: 1703302407399,
          after_start_timestamp: 1703302407300,
          before_end_timestamp: 1703302428899,
          after_end_timestamp: 1703302428800
        },
        limit: 10,
        pagination_key: 'some_pagination_key',
        sort_order: 'ascending'
      )
      expect(calls).to be_a(Retell::SDK::Unofficial::CallList)
    end
  end
end
