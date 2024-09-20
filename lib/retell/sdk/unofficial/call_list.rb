module Retell
  module SDK
    module Unofficial
      class CallList < BaseList
        attr_reader :pagination_key

    def initialize(raw_response)
      super(:calls, raw_response)
          @pagination_key = raw_response[:pagination_key]
        end
      end
    end
  end
end
