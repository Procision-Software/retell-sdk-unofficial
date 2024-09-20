module Retell
  module SDK
    module Unofficial
      class VoiceList < BaseList
        def initialize(raw_response)
          super(:voices, raw_response)
        end
      end
    end
  end
end
