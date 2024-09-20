require 'spec_helper'

RSpec.describe Retell::SDK::Unofficial::PhoneNumber do
  let(:phone_number) do
    @client.phone_number.create()
  end

  describe '#retrieve' do
    it 'retrieves the phone number' do
      expect(@client.phone_number).to receive(:retrieve).with(phone_number).and_return(phone_number)

      retrieved_phone_number = phone_number.retrieve
      expect(retrieved_phone_number).to be_a(Retell::SDK::Unofficial::PhoneNumber)
    end
  end

  describe '#update' do
    it 'updates the phone number' do
      expect(@client.phone_number).to receive(:update).with(phone_number, nickname: 'Updated Phone Number').and_return(phone_number)

      updated_phone_number = phone_number.update(nickname: 'Updated Phone Number')
      expect(updated_phone_number).to be_a(Retell::SDK::Unofficial::PhoneNumber)
    end
  end

  describe '#delete' do
    it 'deletes the phone number' do
      expect(@client.phone_number).to receive(:delete).with(phone_number).and_return(nil)

      result = phone_number.delete
      expect(result).to be_nil
    end
  end
end
