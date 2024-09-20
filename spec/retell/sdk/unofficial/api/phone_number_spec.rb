require 'spec_helper'

RSpec.describe Retell::SDK::Unofficial::API::PhoneNumber do
  let(:client) { @client }

  describe '#create' do
    it 'creates a phone number with minimal parameters' do
      phone_number = client.phone_number.create(
        area_code: 415
      )
      expect(phone_number).to be_a(Retell::SDK::Unofficial::PhoneNumber)
    end

    it 'creates a phone number with all parameters' do
      phone_number = client.phone_number.create(
        area_code: 415,
        inbound_agent_id: 'oBeDLoLOeuAbiuaMFXRtDOLriTJ5tSxD',
        outbound_agent_id: 'oBeDLoLOeuAbiuaMFXRtDOLriTJ5tSxD',
        nickname: 'Frontdesk Number'
      )
      expect(phone_number).to be_a(Retell::SDK::Unofficial::PhoneNumber)
    end
  end

  describe '#import' do
    it 'imports a phone number with minimal parameters' do
      phone_number = client.phone_number.import(
        '+14157774444',
        termination_uri: 'someuri.pstn.twilio.com'
      )
      expect(phone_number).to be_a(Retell::SDK::Unofficial::PhoneNumber)
    end

    it 'imports a phone number with all parameters' do
      phone_number = client.phone_number.import(
        '+14157774444',
        termination_uri: 'someuri.pstn.twilio.com',
        inbound_agent_id: 'oBeDLoLOeuAbiuaMFXRtDOLriTJ5tSxD',
        outbound_agent_id: 'oBeDLoLOeuAbiuaMFXRtDOLriTJ5tSxD',
        nickname: 'Frontdesk Number',
        sip_trunk_auth_username: 'username',
        sip_trunk_auth_password: '123456'
      )
      expect(phone_number).to be_a(Retell::SDK::Unofficial::PhoneNumber)
    end
  end

  describe '#retrieve' do
    it 'retrieves a phone number' do
      phone_number = client.phone_number.retrieve('+14157774444')
        expect(phone_number).to be_a(Retell::SDK::Unofficial::PhoneNumber)
    end
  end

  describe '#update' do
    it 'updates a phone number with minimal parameters' do
      phone_number = client.phone_number.update('+14157774444')
      expect(phone_number).to be_a(Retell::SDK::Unofficial::PhoneNumber)
    end

    it 'updates a phone number with all parameters' do
      phone_number = client.phone_number.update(
        '+14157774444',
        inbound_agent_id: 'oBeDLoLOeuAbiuaMFXRtDOLriTJ5tSxD',
        outbound_agent_id: 'oBeDLoLOeuAbiuaMFXRtDOLriTJ5tSxD',
        nickname: 'Updated Frontdesk Number'
      )
      expect(phone_number).to be_a(Retell::SDK::Unofficial::PhoneNumber)
    end
  end

  describe '#list' do
    it 'lists phone numbers' do
      phone_numbers = client.phone_number.list
      expect(phone_numbers).to be_an(Retell::SDK::Unofficial::PhoneNumberList)
      expect(phone_numbers.first).to be_a(Retell::SDK::Unofficial::PhoneNumber)
    end
  end

  describe '#delete' do
    it 'deletes a phone number' do
      result = client.phone_number.delete('+14157774444')
      expect(result).to be_nil
    end
  end
end
