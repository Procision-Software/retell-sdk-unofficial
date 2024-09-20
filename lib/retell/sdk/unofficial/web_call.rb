module Retell
  module SDK
    module Unofficial
      class WebCall < BaseCall
        @attributes = [:access_token] + BaseCall.attributes

        attr_reader *@attributes

        def initialize(client, raw_response)
          super(client, raw_response)
          @access_token = raw_response[:access_token]
        end

        def retrieve
          @client.call.retrieve(self)
        end
      end
    end
  end
end
