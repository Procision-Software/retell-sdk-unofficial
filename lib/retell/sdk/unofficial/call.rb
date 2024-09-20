module Retell
  module SDK
    module Unofficial
      class Call
        def self.new(client, raw_response)
          case raw_response[:call_type]
          when 'web_call'
            Retell::SDK::Unofficial::WebCall.new(client, raw_response)
          when 'phone_call'
            Retell::SDK::Unofficial::PhoneCall.new(client, raw_response)
          else
            raise ArgumentError, "Unknown call type: #{raw_response[:call_type]}"
          end
        end
      end
    end
  end
end
