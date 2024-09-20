require 'spec_helper'

RSpec.describe Retell::SDK::Unofficial::API::Voice do
  let(:client) { @client }

  describe '#retrieve' do
    it 'retrieves a voice' do
      voice = client.voice.retrieve('11labs-Adrian')
      expect(voice).to be_a(Retell::SDK::Unofficial::Voice)
      expect(voice.voice_id).to eq('11labs-Adrian')
    end

    it 'raises an error for empty voice_id' do
      expect { client.voice.retrieve('') }.to raise_error(ArgumentError, /Expected a non-empty value for `voice_id`/)
    end
  end

  describe '#list' do
    it 'lists voices' do
      voices = client.voice.list
      expect(voices).to be_a(Retell::SDK::Unofficial::VoiceList)
      expect(voices.first).to be_a(Retell::SDK::Unofficial::Voice)
    end
  end
end
