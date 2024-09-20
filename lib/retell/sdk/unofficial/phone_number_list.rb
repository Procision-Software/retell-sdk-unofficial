module Retell
  module SDK
    module Unofficial
      class PhoneNumberList < BaseList
        def initialize(raw_response)
          super(:phone_numbers, raw_response)
        end
      end
    end
  end
end
