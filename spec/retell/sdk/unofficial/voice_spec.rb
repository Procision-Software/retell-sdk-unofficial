require 'spec_helper'

RSpec.describe Retell::SDK::Unofficial::Voice do
  let(:voice) {
    @client.voice.retrieve('1234567890')
  }

  describe '#retrieve' do
    it 'retrieves the voice' do
      expect(@client.voice).to receive(:retrieve).with(voice).and_return(voice)

      retrieved_voice = voice.retrieve
      expect(retrieved_voice).to be_a(Retell::SDK::Unofficial::Voice)
    end
  end
end
