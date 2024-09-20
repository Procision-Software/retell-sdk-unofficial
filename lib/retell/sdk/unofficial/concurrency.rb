module Retell
  module SDK
    module Unofficial
      class Concurrency < Base
        @attributes = [
          :current_concurrency, :concurrency_limit
        ]

        attr_reader *@attributes

        def retrieve
          @client.concurrency.retrieve()
        end
      end
    end
  end
end
