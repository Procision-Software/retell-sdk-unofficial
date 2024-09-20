module Retell
  module SDK
    module Unofficial
      class AgentList < BaseList
        def initialize(raw_response)
          super(:agents, raw_response)
        end
      end
    end
  end
end
