module Retell
  module SDK
    module Unofficial
      class PhoneCall < BaseCall
        @attributes = [:from_number, :to_number, :direction] + BaseCall.attributes

        attr_reader *@attributes

        def initialize(client, raw_response)
          super(client, raw_response)
          @from_number = raw_response[:from_number]
          @to_number = raw_response[:to_number]
          @direction = raw_response[:direction]
        end

        def retrieve
          @client.call.retrieve(self)
        end
      end
    end
  end
end
