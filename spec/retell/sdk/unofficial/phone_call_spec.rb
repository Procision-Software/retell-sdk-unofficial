require 'spec_helper'

RSpec.describe Retell::SDK::Unofficial::PhoneCall do
  let(:phone_call) {
    @client.call.create_phone_call(
      from_number: '+1234567890',
      to_number: '+1987654321'
    )
   }

  describe '#retrieve' do
    it 'retrieves the phone call' do
      expect(@client.call).to receive(:retrieve).with(phone_call).and_return(phone_call)

      retrieved_phone_call = phone_call.retrieve
      expect(retrieved_phone_call).to be_a(Retell::SDK::Unofficial::PhoneCall)
    end
  end
end
