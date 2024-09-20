require 'spec_helper'

RSpec.describe Retell::SDK::Unofficial::RetellLLM do
  let(:retell_llm) do
    @client.retell_llm.create()
  end

  describe '#retrieve' do
    it 'retrieves the LLM' do
      expect(@client.retell_llm).to receive(:retrieve).with(retell_llm).and_return(retell_llm)

      retrieved_retell_llm = retell_llm.retrieve
      expect(retrieved_retell_llm).to be_a(Retell::SDK::Unofficial::RetellLLM)
    end
  end

  describe '#update' do
    it 'updates the LLM' do
      expect(@client.retell_llm).to receive(:update).with(retell_llm, general_prompt: 'Yo').and_return(retell_llm)

      updated_retell_llm = retell_llm.update(general_prompt: 'Yo')
      expect(updated_retell_llm).to be_a(Retell::SDK::Unofficial::RetellLLM)
    end
  end

  describe '#delete' do
    it 'deletes the LLM' do
      expect(@client.retell_llm).to receive(:delete).with(retell_llm).and_return(nil)

      result = retell_llm.delete
      expect(result).to be_nil
    end
  end
end
