require_relative 'unofficial/client'
require_relative 'unofficial/api/agent'
require_relative 'unofficial/api/call'
require_relative 'unofficial/api/retell_llm'
require_relative 'unofficial/api/phone_number'
require_relative 'unofficial/api/voice'
require_relative 'unofficial/api/concurrency'
require_relative 'unofficial/base'
require_relative 'unofficial/base_list'
require_relative 'unofficial/agent'
require_relative 'unofficial/agent_list'
require_relative 'unofficial/call'
require_relative 'unofficial/base_call'
require_relative 'unofficial/web_call'
require_relative 'unofficial/phone_call'
require_relative 'unofficial/call_list'
require_relative 'unofficial/retell_llm'
require_relative 'unofficial/retell_llm_list'
require_relative 'unofficial/phone_number'
require_relative 'unofficial/phone_number_list'
require_relative 'unofficial/voice'
require_relative 'unofficial/voice_list'
require_relative 'unofficial/concurrency'

module Retell
  module SDK
    module Unofficial
      def self.new(api_key:, base_url: nil)
        Client.new(base_url: base_url, api_key: api_key)
      end
    end
  end
end
