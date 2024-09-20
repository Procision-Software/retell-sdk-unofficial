module Retell
  module SDK
    module Unofficial
      class RetellLLMList < BaseList
        def initialize(raw_response)
          super(:llms, raw_response)
        end
      end
    end
  end
end
